require_relative '../input_fetcher'

INPUT = InputFetcher.day(3).split("\n")
MAP = INPUT.map { |row| row.each_char.to_a }

class Map
  Position = Struct.new(:x, :y)

  attr_reader :position

  def initialize(map)
    @map = map
    @position = Position.new(0, 0)
  end

  def slide_tree_count(x, y)
    slope = Position.new(x, y)
    map_width = @map.first.size
    map_height = @map.size
    count = 0

    while position.y + 1 < map_height
      position.x += slope.x
      position.y += slope.y

      count += 1 if @map[position.y][position.x % map_width] == '#'
    end

    count
  end
end

map_count = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
].map do |x, y|
  Map.new(MAP).slide_tree_count(x, y)
end

p map_count.reduce(:*) # => 9709761600
