require_relative '../input_fetcher'

INPUT = InputFetcher.day(1).split("\n").map(&:to_i)
puts INPUT.combination(3).detect { |ints| ints.sum == 2020 }.reduce(:*) # => 199132160
