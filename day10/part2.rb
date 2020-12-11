require_relative '../input_fetcher'

INPUT = InputFetcher.day(10).split("\n")
INPUT.map!(&:to_i)
INPUT.sort!
INPUT.prepend(0)

ALL_ADAPTERS = {}

class Adapter
  attr_reader :joltage_rating, :can_come_from

  def initialize(joltage_rating)
    @joltage_rating = joltage_rating
    calculate_can_come_from
    count_possibility
  end

  def count_possibility
    @count_possibility ||= begin
      return 1 if @can_come_from.empty?

      @can_come_from.sum do |can_come_from|
        ALL_ADAPTERS[can_come_from].count_possibility
      end
    end
  end

  def calculate_can_come_from
    possible = (joltage_rating - 3..joltage_rating - 1).to_a
    possible.select! { |i| ALL_ADAPTERS.key?(i) }
    @can_come_from = possible
  end
end

INPUT.each do |adapter|
  ALL_ADAPTERS[adapter] = Adapter.new(adapter)
end

p ALL_ADAPTERS[INPUT.last].count_possibility # => 56693912375296
