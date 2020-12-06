require_relative '../input_fetcher'

INPUT = InputFetcher.day(6).split("\n\n")

count = 0
INPUT.each do |i|
  people_count = i.split("\n").count
  all_answers = i.gsub("\n", '')

  all_answers.chars.uniq.each do |c|
    count += 1 if all_answers.count(c) == people_count
  end
end

p count # 3202
