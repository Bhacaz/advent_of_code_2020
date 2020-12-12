# frozen_string_literal: true

require_relative '../input_fetcher'
require 'set'

INPUT = InputFetcher.day(11).split("\n").map(&:chars)

class Map
  def initialize(map_data)
    @map_data = map_data
    @map_hashes = Set.new
    @x_size = @map_data.first.size
    @y_size = @map_data.size
  end

  def calculate
    @map_hashes << @map_data.hash
    dup_map = @map_data.map(&:dup)
    (0..@y_size - 1).each do |y|
      (0..@x_size - 1).each do |x|
        current_place = @map_data[y][x]
        next if current_place == '.'

        around_count = occupied_around_count(x, y)
        if current_place == 'L' && around_count.zero?
          dup_map[y][x] = '#'
        elsif current_place == '#' && around_count >= 5
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

  def x_offset_array
    @x_offset_array ||= (0..@x_size - 1).chain((-(@x_size - 1)..0).to_a.reverse).to_a
  end

  def y_offset_array
    @y_offset_array ||= (0..@y_size - 1).chain((-(@y_size - 1)..0).to_a.reverse).to_a
  end

  def offsets
    @offsets ||=
      begin
        a = []
        x_offset_array.each do |x_offset|
          y_offset_array.each do |y_offset|
            next if x_offset.zero? && y_offset.zero?
            next unless x_offset.abs == y_offset.abs || x_offset.zero? || y_offset.zero?

            a << [x_offset, y_offset]
          end
        end
        a
      end
  end

  def occupied_around_count(original_x, original_y)
    # 0, y
    # 0, -y
    # x, 0
    # -x, 0
    # x, y
    # -x, y
    # x, -y
    # -x, -y
    items = Array.new(8)

    offsets.each do |x_offset, y_offset|
      x = x_offset + original_x
      y = y_offset + original_y
      next if x.negative? || x >= @x_size
      next if y.negative? || y >= @y_size

      row_index =
        if x_offset.zero? && y_offset.positive?
          0
        elsif x_offset.zero? && y_offset.negative?
          1
        elsif x_offset.positive? && y_offset.zero?
          2
        elsif x_offset.negative? && y_offset.zero?
          3
        elsif x_offset.positive? && y_offset.positive?
          4
        elsif x_offset.negative? && y_offset.positive?
          5
        elsif x_offset.positive? && y_offset.negative?
          6
        elsif x_offset.negative? && y_offset.negative?
          7
        end
      data_in_map = @map_data[y][x]
      items[row_index] = data_in_map if row_index && items[row_index].nil? && data_in_map != '.'
    end

    items.count { |place| place == '#' }
  end
end

p Map.new(INPUT).calculate # => 1990
