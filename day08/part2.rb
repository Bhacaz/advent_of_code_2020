require_relative '../input_fetcher'

INPUT = InputFetcher.day(8).split("\n")

class Computer
  attr_reader :accumulator

  def initialize(program)
    @program = program.dup
    @original_program = program
    reset
    @position_to_replace = 0
  end

  def reset
    @program = @original_program.dup
    @accumulator = 0
    @position = 0
    @executed_instruction = []
  end

  def run
    execute while !@executed_instruction.include?(@position) && @position < @original_program.size

    unless @position == @original_program.size
      replace_instruction
      run
    end
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

  def replace_instruction
    reset
    operation = @program[@position_to_replace]
    case operation[0..2]
    when 'jmp'
      @program[@position_to_replace] = operation.gsub('jmp', 'nop')
    when 'nop'
      @program[@position_to_replace] = operation.gsub('nop', 'jmp')
    end
    @position_to_replace += 1
  end
end

computer = Computer.new(INPUT)
computer.run
p computer.accumulator # => 1270
