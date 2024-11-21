class Robot < ApplicationRecord
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  def place(x, y, facing)
    return unless valid_position?(x, y) && valid_facing?(facing)

    self.x = x
    self.y = y
    self.facing = facing
    save
  end

  def move(table)
    return unless placed?

    next_x, next_y = next_position
    return unless table.valid_position?(next_x, next_y)

    self.x = next_x
    self.y = next_y
    save
  end

  def rotate_left
    return unless placed?

    self.facing = DIRECTIONS[(DIRECTIONS.index(facing) - 1) % DIRECTIONS.size]
    save
  end

  def rotate_right
    return unless placed?

    self.facing = DIRECTIONS[(DIRECTIONS.index(facing) + 1) % DIRECTIONS.size]
    save
  end

  def report
    return "Robot is not placed on the table" unless placed?

    "#{x},#{y},#{facing}"
  end

  private

  def placed?
    x.present? && y.present? && facing.present?
  end

  def next_position
    case facing
    when 'NORTH' then [x, y + 1]
    when 'EAST' then [x + 1, y]
    when 'SOUTH' then [x, y - 1]
    when 'WEST' then [x - 1, y]
    end
  end

  def valid_position?(x, y)
    x.is_a?(Integer) && y.is_a?(Integer)
  end

  def valid_facing?(facing)
    DIRECTIONS.include?(facing)
  end
end
