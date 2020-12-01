require_relative '../input_fetcher'

INPUT = InputFetcher.day(1).map(&:to_i)
puts INPUT.combination(2).detect { |ints| ints.reduce(&:+) == 2020 }.reduce(&:*) # => 1006176
