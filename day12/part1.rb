require_relative '../input_fetcher'

INPUT = InputFetcher.day(12).split("\n")

class Ship
  def initialize
    @x = 0
    @y = 0
    @angle = 0
  end

  def navigate(actions)
    actions.each do |action|
      direction = action[0].downcase
      unit = action[1..-1].to_i

      send(direction.to_sym, unit)
    end
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
    @angle = (@angle - unit) % 360
  end

  def r(unit)
    @angle = (@angle + unit) % 360
  end

  # sin(o) = H/O
  # cos(o) = H/A
  # tan(O) = O/A
  def f(unit)
    x = (unit / ::Math.cos(angle_radians)).abs
    y = (unit / ::Math.sin(angle_radians)).abs

    operator =
      if (@angle % 360).zero? || (@angle % 270).zero?
        :+
      else
        :-
      end

    @x = @x.send(operator, x) if !x.infinite? && x.abs <= unit
    @y = @y.send(operator, y) if !y.infinite? && y.abs <= unit
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
p ship.manhattan_distance # => 1186
