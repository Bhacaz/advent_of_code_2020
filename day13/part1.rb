require_relative '../input_fetcher'

INPUT = InputFetcher.day(13).split("\n")

estimate = INPUT[0].to_i
ids = INPUT[1].split(',').reject { |i| i == 'x' }.map(&:to_i)

p estimate
p ids

class Bus
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def min_depart(estimate)
    a = estimate / @id
    ((a + 1) * @id) - estimate
  end
end


bus = ids.map { |id| Bus.new(id) }

min_bus = bus.min_by { |b| b.min_depart(estimate) }

p min_bus.id * min_bus.min_depart(estimate)

