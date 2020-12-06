require_relative '../input_fetcher'

INPUT = InputFetcher.day(6).split("\n\n")

sum = INPUT.sum do |i|
  i.gsub("\n", '').chars.uniq.size
end

p sum # 6633
