require_relative '../input_fetcher'

INPUT = InputFetcher.day(3).split("\n")

MAP = INPUT.map { |row| row.each_char.to_a }

map_width = MAP.first.size
map_height = MAP.size

Position = Struct.new(:x, :y)
position = Position.new(0, 0)

slope = Position.new(3, 1)
count = 0

while position.y + 1 < map_height
  position.x += slope.x
  position.y += slope.y

  count += 1 if MAP[position.y][position.x % map_width] == '#'
end

p count # => 278



