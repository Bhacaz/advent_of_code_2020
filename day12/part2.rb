require_relative '../input_fetcher'

INPUT = InputFetcher.day(12).split("\n")

class Waypoint
  attr_reader :x, :y, :angle

  def initialize
    @x = 10
    @y = 1
    @angle = 0
  end

  def n(unit)
    @y += unit
  end

  def s(unit)
    @y -= unit
  end

  def e(unit)
    @x += unit
  end

  def w(unit)
    @x -= unit
  end

  def l(unit)
    (unit / 90).times do
      y = @x
      @x = -@y
      @y = y
    end
  end

  def r(unit)
    (unit / 90).times do
      y = -@x
      @x = @y
      @y = y
    end
  end
end

class Ship
  def initialize
    @x = 0
    @y = 0
    @angle = 0
    @waypoint = Waypoint.new
  end

  def navigate(actions)
    actions.each do |action|
      direction = action[0].downcase
      unit = action[1..-1].to_i

      if direction == 'f'
        send(direction.to_sym, unit)
      else
        @waypoint.send(direction.to_sym, unit)
      end
    end
  end

  def f(unit)
    @x += unit * @waypoint.x
    @y += unit * @waypoint.y
  end

  def angle_radians
    @angle * (Math::PI / 180.0)
  end

  def manhattan_distance
    (@x.abs + @y.abs).to_i
  end
end

ship = Ship.new
ship.navigate(INPUT)
p ship.manhattan_distance # => 47806
