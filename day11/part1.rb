require_relative '../input_fetcher'
require 'set'

INPUT = InputFetcher.day(11).split("\n").map(&:chars)

class Map
  def initialize(map_data)
    @map_data = map_data
    @map_hashes = Set.new
  end

  def calculate
    @map_hashes << @map_data.hash
    dup_map = @map_data.map(&:dup)
    (0..@map_data.size - 1).each do |y|
      (0..@map_data.first.size - 1).each do |x|
        current_place = @map_data[y][x]
        next if current_place == '.'

        around_count = occupied_around_count(x, y)
        if current_place == 'L' && around_count.zero?
          dup_map[y][x] = '#'
        elsif current_place == '#' && around_count >= 4
          dup_map[y][x] = 'L'
        end
      end
    end

    until @map_hashes.include?(dup_map.hash)
      @map_data = dup_map.map(&:dup)
      calculate
    end
    @map_data.flatten.count('#')
  end

  def occupied_around_count(original_x, original_y)
    items = []
    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        x = x_offset + original_x
        y = y_offset + original_y
        next if x_offset.zero? && y_offset.zero?
        next if x.negative? || x >= @map_data.first.size
        next if y.negative? || y >= @map_data.size

        items << @map_data[y][x]
      end
    end

    items.count { |place| place == '#' }
  end
end

p Map.new(INPUT).calculate
