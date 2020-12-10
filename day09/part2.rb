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

wrong_number

wrong_set = []

(2..INPUT.size).each do |set_size|
  (0..INPUT.size).each do |index|
    last_index = index + set_size - 1
    next if last_index >= INPUT.size

    sum = INPUT[index..last_index].sum
    wrong_set = INPUT[index..last_index] if sum == wrong_number
  end
end

p wrong_set.min + wrong_set.max # => 4023754
