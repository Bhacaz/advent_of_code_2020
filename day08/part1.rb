require_relative '../input_fetcher'

INPUT = InputFetcher.day(8).split("\n")

class Computer
  attr_reader :accumulator

  def initialize(program)
    @program = program
    @accumulator = 0
    @position = 0
    @executed_instruction = []
  end

  def run
    execute until @executed_instruction.include?(@position)
  end

  def execute
    operation, arg = instruction
    @executed_instruction << @position
    case operation
    when 'acc'
      @accumulator += arg
      @position += 1
    when 'jmp'
      @position += arg
    when 'nop'
      @position += 1
    end
  end

  def instruction
    operation, arg = @program[@position].split
    [operation, arg.to_i]
  end
end

computer = Computer.new(INPUT)
computer.run
p computer.accumulator # => 1475
