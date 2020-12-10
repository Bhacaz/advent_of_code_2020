require_relative '../input_fetcher'
require 'set'

INPUT = InputFetcher.day(9).split("\n").map(&:to_i)

def list_sum(numbers)
  numbers.combination(2).map(&:sum).to_set
end

wrong_number = nil
INPUT[25..-1].each_with_index do |number, index|
  wrong_number = number unless list_sum(INPUT[index..(index + 24)]).include?(number)
end

p wrong_number # => 27911108
