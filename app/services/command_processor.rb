class CommandProcessor
  attr_reader :robot, :table

  def initialize
    @robot = Robot.new
    @table = Table.new
  end

  def execute(command)
    case command
    when /^PLACE\s(\d+),(\d+),(NORTH|SOUTH|EAST|WEST)$/i
      x, y, facing = $1.to_i, $2.to_i, $3.upcase
      robot.place(x, y, facing)
    when 'MOVE'
      robot.move(table)
    when 'LEFT'
      robot.rotate_left
    when 'RIGHT'
      robot.rotate_right
    when 'REPORT'
      puts robot.report
    else
      puts "Invalid command"
    end
  end
end
