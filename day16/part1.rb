require_relative '../input_fetcher'

INPUT = InputFetcher.day(16).split("\n\n")

class Rule
  attr_reader :min, :max

  def initialize(min, max)
    @min = min
    @max = max
  end
end

class Field
  attr_reader :name

  def initialize(name, rules)
    @name = name
    @rules = rules
  end

  def number_valid?(number)
    @rules.any? do |rule|
      number >= rule.min && number <= rule.max
    end
  end
end

class Ticket
  def initialize(numbers)
    @numbers = numbers
  end

  def invalid_numbers(fields)
    @numbers.select do |number|
      fields.none? { |field| field.number_valid?(number) }
    end
  end
end

RULES_REGEX = /(.+\w)\: (.+\d?)-(.+\d?) or (.+\d?)-(.+\d?)/.freeze

fields = []
tickets = []

INPUT[0].split("\n").each do |i|
  name, min1, max1, min2, max2 = i.match(RULES_REGEX).captures
  r1 = Rule.new(min1.to_i, max1.to_i)
  r2 = Rule.new(min2.to_i, max2.to_i)
  fields << Field.new(name, [r1, r2])
end

INPUT[2].split("\n")[1..-1].each do |i|
  tickets << Ticket.new(i.split(',').map(&:to_i))
end

invalid = tickets.flat_map do |ticket|
  ticket.invalid_numbers(fields)
end

p invalid.sum # => 22057
