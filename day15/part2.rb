require_relative '../input_fetcher'

INPUT = InputFetcher.day(1).split("\n").first.split(',').map(&:to_i)

$last = nil
$spoken = Hash.new { |h, k| h[k] = [] }

INPUT.each_with_index do |n, index|
  $spoken[n] << index + 1
end

$last = INPUT[-1]

(INPUT.size + 1..30000000).each do |i|
  spoken_last = $spoken[$last]
  $last = spoken_last.size == 1 ? 0 : spoken_last.reduce(:-).abs
  spoken_array = $spoken[$last]
  spoken_array << i
  spoken_array.shift if spoken_array.size == 3
end

p $last # => 48568
