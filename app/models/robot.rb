class Robot
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  attr_reader :x, :y, :facing

  def initialize
    @x = nil
    @y = nil
    @facing = nil
  end

  def place(x, y, facing, table)
    if table.valid_position?(x, y) && DIRECTIONS.include?(facing)
      @x = x
      @y = y
      @facing = facing
    else
      raise ArgumentError, "Invalid PLACE command: #{x},#{y},#{facing}"
    end
  end

  def move(table)
    raise "Robot is not placed on the table" unless placed?

    next_x, next_y = next_position
    if table.valid_position?(next_x, next_y)
      @x = next_x
      @y = next_y
    else
      puts "Move ignored to prevent robot from falling off the table."
    end
  end

  def rotate_left
    raise "Robot is not placed on the table" unless placed?

    @facing = DIRECTIONS[(DIRECTIONS.index(@facing) - 1) % DIRECTIONS.size]
  end

  def rotate_right
    raise "Robot is not placed on the table" unless placed?

    @facing = DIRECTIONS[(DIRECTIONS.index(@facing) + 1) % DIRECTIONS.size]
  end

  def report
    if placed?
      "#{@x},#{@y},#{@facing}"
    else
      "Robot is not placed on the table"
    end
  end

  private

  def placed?
    !@x.nil? && !@y.nil? && !@facing.nil?
  end

  def next_position
    case @facing
    when "NORTH" then [ @x, @y + 1 ]
    when "EAST" then [ @x + 1, @y ]
    when "SOUTH" then [ @x, @y - 1 ]
    when "WEST" then [ @x - 1, @y ]
    end
  end
end
