require_relative '../input_fetcher'

INPUT = InputFetcher.day(14).split("\n")
INSTRUCTION_REFEX = /mem\[(\d+)\] = (\d+)/

$programs = {}

key_mask = nil

INPUT.each do |i|
  if i.start_with?('mask')
    key_mask = i.split(' = ').last
    $programs[key_mask] = []
  else
    $programs[key_mask] << i.match(INSTRUCTION_REFEX).captures.map(&:to_i)
  end
end

pp $programs

$memory = {}

class Program
  def initialize(mask, instructions)
    @mask = mask
    @instructions = instructions
  end

  def execute
    @instructions.each do |mem, value|
      p bin_value = value.to_s(2).rjust(36, '0')
      $memory[mem] = apply_mask(bin_value).to_i(2)
    end
  end

  def apply_mask(bin_value)
    bin_value.dup.each_char.with_index do |_c, index|
      bin_value[index] = @mask[index] if @mask[index] != 'X'
    end
    bin_value
  end
end

$programs.each do |mask, instructions|
  Program.new(mask, instructions).execute
end

p $memory.values.sum
