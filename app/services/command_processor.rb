class CommandProcessor
  def initialize(robot, table)
    @robot = robot
    @table = table
  end

  def execute(command)
    case command.strip.upcase
    when /^PLACE\s(\d+),(\d+),(NORTH|SOUTH|EAST|WEST)$/i
      x, y, facing = $1.to_i, $2.to_i, $3.upcase
      @robot.place(x, y, facing, @table)
    when 'MOVE'
      @robot.move(@table)
    when 'LEFT'
      @robot.rotate_left
    when 'RIGHT'
      @robot.rotate_right
    when 'REPORT'
      puts @robot.report
    else
      puts "Invalid command: #{command}"
    end
  rescue ArgumentError, RuntimeError => e
    puts "Error: #{e.message}"
  end
end
