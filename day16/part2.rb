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
  attr_reader :numbers

  def initialize(numbers)
    @numbers = numbers
  end

  def invalid_numbers(fields)
    @numbers.select do |number|
      fields.none? { |field| field.number_valid?(number) }
    end
  end

  def valid?(field, number_index)
    field.number_valid?(@numbers[number_index])
  end
end

RULES_REGEX = /(.+\w)\: (.+\d?)-(.+\d?) or (.+\d?)-(.+\d?)/.freeze

fields = []
tickets = []

INPUT[0].split("\n").each do |i|
  name, min1, max1, min2, max2 = i.match(RULES_REGEX).captures
  r1 = Rule.new(min1.to_i, max1.to_i)
  r2 =  Rule.new(min2.to_i, max2.to_i)
  fields << Field.new(name, [r1, r2])
end

my_ticket = Ticket.new(INPUT[1].split("\n")[-1].split(',').map(&:to_i))

INPUT[2].split("\n")[1..-1].each do |i|
  tickets << Ticket.new(i.split(',').map(&:to_i))
end

tickets = tickets.select do |ticket|
  ticket.invalid_numbers(fields).empty?
end

tickets << my_ticket

sequence = []

fields_size = fields.size

(0..fields_size - 1).each do |index|
  all_tickets_values = tickets.flat_map { |t| t.numbers[index] }
  sequence << fields.select do |field|
    all_tickets_values.all? { |number| field.number_valid?(number) }
  end.map(&:name)
end

require 'set'

already_check = Set.new

until sequence.all? { |s| s.size == 1 }
  good_field = sequence.detect { |s| s.size == 1 && !already_check.include?(s.first) }.first
  already_check << good_field
  sequence.each do |seq|
    seq.delete(good_field) unless seq.size == 1
  end
end

sequence.flatten!

all_departure_values = []
sequence.each_with_index do |field_name, index|
  all_departure_values << my_ticket.numbers[index] if field_name.start_with?('departure')
end

p all_departure_values.reduce(:*) # => 1093427331937
