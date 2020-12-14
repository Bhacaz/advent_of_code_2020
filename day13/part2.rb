require_relative '../input_fetcher'

INPUT = InputFetcher.day(13).split("\n")

ids = INPUT[1].split(',')

id_min_index = []
ids.each_with_index do |id, index|
  id_min_index << id.to_i - index if id != 'x'
end


n = id_min_index.reduce(:*)


