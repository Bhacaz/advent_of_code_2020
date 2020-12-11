require_relative '../input_fetcher'

INPUT = InputFetcher.day(10).split("\n").map(&:to_i).sort

class Adapter
  attr_reader :input_voltage, :joltage_rating

  def initialize(joltage_rating, input_voltage)
    @joltage_rating = joltage_rating
    @input_voltage = input_voltage
  end

  def difference
    @joltage_rating - @input_voltage
  end
end

# Add the built-in adapter
INPUT << INPUT.last + 3

grouped_diff = Hash.new do |hash, key|
  hash[key] = 0
end

last_voltage_diff = 0

INPUT.each do |adapter|
  adapter_object = Adapter.new(adapter, last_voltage_diff)
  grouped_diff[adapter_object.difference] += 1
  last_voltage_diff = adapter_object.joltage_rating
end

p grouped_diff[1] * grouped_diff[3] # => 1656
