require "minitest/autorun"
require_relative "../../app/models/robot"
require_relative "../../app/models/table"
require_relative "../../app/services/command_processor"

class CommandProcessorTest < Minitest::Test
  def setup
    @robot = Robot.new
    @table = Table.new
    @processor = CommandProcessor.new(@robot, @table)
  end

  def test_process_place_and_move_commands
    @processor.execute("PLACE 0,0,NORTH")
    assert_equal "0,0,NORTH", @robot.report

    @processor.execute("MOVE")
    assert_equal "0,1,NORTH", @robot.report
  end

  def test_process_invalid_command
    output = capture_io { @processor.execute("INVALID COMMAND") }
    assert_match(/Invalid command/, output.first)
  end

  def test_process_report_when_robot_is_not_placed
    output = capture_io { @processor.execute("REPORT") }
    assert_match(/Robot is not placed on the table/, output.first)
  end

  def test_robot_ignores_move_command_when_not_placed
    output = capture_io { @processor.execute("MOVE") }
    assert_match(/Robot is not placed on the table/, output.first)
  end

  def test_robot_ignores_left_and_right_commands_when_not_placed
    output = capture_io { @processor.execute("LEFT") }
    assert_match(/Robot is not placed on the table/, output.first)

    output = capture_io { @processor.execute("RIGHT") }
    assert_match(/Robot is not placed on the table/, output.first)
  end

  def test_robot_handles_boundary_conditions
    @processor.execute("PLACE 0,0,SOUTH")
    @processor.execute("MOVE")
    assert_equal "0,0,SOUTH", @robot.report

    @processor.execute("PLACE 4,4,NORTH")
    @processor.execute("MOVE")
    assert_equal "4,4,NORTH", @robot.report

    @processor.execute("PLACE 0,0,WEST")
    @processor.execute("MOVE")
    assert_equal "0,0,WEST", @robot.report
  end

  def test_robot_executes_complex_command_sequences
    @processor.execute("PLACE 1,2,EAST")
    @processor.execute("MOVE")
    @processor.execute("MOVE")
    @processor.execute("LEFT")
    @processor.execute("MOVE")
    assert_equal "3,3,NORTH", @robot.report
  end

  def test_robot_handles_multiple_place_commands
    @processor.execute("PLACE 1,1,NORTH")
    assert_equal "1,1,NORTH", @robot.report

    @processor.execute("PLACE 2,2,WEST")
    assert_equal "2,2,WEST", @robot.report
  end
end
