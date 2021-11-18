# ProcessCommandService.new.call(commands)

class ProcessCommandService
  def initilize
    @robot_placed = false
    @x = nil
    @y = nil
    @direction = nil
  end

  def call(commands)
    begin
      process_commands(commands)
      if @robot_placed
        {success: true, data: [@x , @y, @direction]}
      else
        {success: false, error: "Robot not placed"}
      end
    rescue ArgumentError => exception
      {success: false, error: exception.message}
    end
  end

  private
  def process_commands(commands)
    if commands.present?
    commands.each do |command|
      if cmd = command.match(command_regex[:place])
         validate_placement!(cmd)
        @x, @y, @direction = cmd[1].to_i, cmd[2].to_i, cmd[3]
      elsif cmd = command.match(command_regex[:move])
        move() if @robot_placed
      elsif cmd = command.match(command_regex[:left])
        left() if @robot_placed
      elsif cmd = command.match(command_regex[:right])
        right() if @robot_placed
      elsif cmd = command.match(command_regex[:report])
        return if @robot_placed
      else
        next
      end
    end
  end
  end

  def command_regex
    {
      place: /PLACE (\d+),(\d+),(\w+)/,
      move: /MOVE/,
      left: /LEFT/,
      right: /RIGHT/,
      report: /REPORT/,
    }
  end

  def validate_placement!(cmd)

    if cmd[1].to_i.in?(0..4) && cmd[2].to_i.in?(0..4) && directions.include?(cmd[3])
      @robot_placed = true
    end
  end

  def move
    case @direction
    when 'NORTH'
      @y = @y + 1 if @y < 5
    when 'SOUTH'
      @y = @y - 1 if @y > 0
    when 'EAST'
      @x = @x + 1 if @x < 5
    when 'WEST'
      @x = @x - 1 if @x > 0
    end
  end

  def left
    left_direction_index = (directions.find_index(@direction) - 1) % directions.length

    @direction = directions[left_direction_index]
  end

  def right
    right_direction_index = (directions.find_index(@direction) + 1) % directions.length

    @direction = directions[right_direction_index]
  end

  def directions
    ['NORTH', 'EAST', 'SOUTH', 'WEST']
  end
end
