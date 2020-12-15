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

$memory = {}

class Program
  def initialize(mask, instructions)
    @mask = mask
    @instructions = instructions
  end

  def execute
    @instructions.each do |mem, value|
      bin_value = mem.to_s(2).rjust(36, '0')
      mem_addresses(bin_value).each do |mem|
       $memory[mem.to_i(2)] = value
      end
    end
  end

  def mem_addresses(bin_value)
    # Apply 1 and X overwrite
    bin_value.dup.each_char.with_index do |_c, index|
      bin_value[index] = '1' if @mask[index] == '1'
      bin_value[index] = 'X' if @mask[index] == 'X'
    end

    addreses = [bin_value]

    bin_value.count('X').times do
      addreses.dup.each do |add|

        i = add.index('X')
        add[i] = '0'
        addreses << add.dup
        add[i] = '1'
        addreses << add.dup
      end
    end

    addreses.uniq
  end
end

$programs.each do |mask, instructions|
  Program.new(mask, instructions).execute
end

p $memory.values.sum
