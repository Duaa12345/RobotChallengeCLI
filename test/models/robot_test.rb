require "minitest/autorun"
require_relative "../../app/models/robot"
require_relative "../../app/models/table"

class RobotTest < Minitest::Test
  def setup
    @robot = Robot.new
    @table = Table.new
  end

  def test_robot_moves_forward_correctly
    @robot.place(0, 0, "NORTH", @table)
    @robot.move(@table)
    assert_equal "0,1,NORTH", @robot.report

    @robot.place(1, 1, "EAST", @table)
    @robot.move(@table)
    assert_equal "2,1,EAST", @robot.report
  end

  def test_robot_rotates_correctly_to_the_left_and_right
    @robot.place(0, 0, "NORTH", @table)

    @robot.rotate_left
    assert_equal "0,0,WEST", @robot.report

    @robot.rotate_left
    assert_equal "0,0,SOUTH", @robot.report

    @robot.rotate_right
    assert_equal "0,0,WEST", @robot.report

    @robot.rotate_right
    assert_equal "0,0,NORTH", @robot.report
  end

  def test_robot_prevents_invalid_placement_outside_table_boundaries
    assert_raises(ArgumentError) { @robot.place(-1, 0, "NORTH", @table) }
    assert_raises(ArgumentError) { @robot.place(5, 5, "SOUTH", @table) }
  end

  def test_robot_prevents_invalid_placement_with_incorrect_facing_direction
    assert_raises(ArgumentError) { @robot.place(0, 0, "INVALID", @table) }
    assert_raises(ArgumentError) { @robot.place(0, 0, "123", @table) }
  end

  def test_robot_prevents_movement_off_the_table
    @robot.place(0, 0, "SOUTH", @table)
    @robot.move(@table)
    assert_equal "0,0,SOUTH", @robot.report

    @robot.place(4, 4, "NORTH", @table)
    @robot.move(@table)
    assert_equal "4,4,NORTH", @robot.report

    @robot.place(0, 0, "WEST", @table)
    @robot.move(@table)
    assert_equal "0,0,WEST", @robot.report
  end

  def test_robot_correctly_reports_position_and_direction
    @robot.place(2, 2, "EAST", @table)
    assert_equal "2,2,EAST", @robot.report

    @robot.place(3, 3, "SOUTH", @table)
    assert_equal "3,3,SOUTH", @robot.report
  end

  def test_robot_reports_not_placed_when_no_valid_place_command_issued
    assert_equal "Robot is not placed on the table", @robot.report
  end
end
