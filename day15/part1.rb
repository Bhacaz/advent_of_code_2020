require_relative '../input_fetcher'

INPUT = InputFetcher.day(1).split("\n").first.split(',').map(&:to_i)

$sequence = []
$spoken = Hash.new { |h, k| h[k] = [] }

def number_to_speak(number)
  $spoken[number][-1] - $spoken[number][-2]
end

(1..2020).each do |i|
  n = if INPUT[i - 1]
        INPUT[i - 1]
      else
        last = $sequence[-1]
        if $spoken[last].size == 1
          0
        else
          number_to_speak(last)
        end
      end
  $sequence << n
  $spoken[n] << i
end

p $sequence[-1] # => 1111
