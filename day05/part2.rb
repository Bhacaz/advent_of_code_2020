require_relative '../input_fetcher'

INPUT = InputFetcher.day(5).split("\n")

ROWS = (0..127).to_a.freeze
COLUMNS = (0..7).to_a.freeze

class Array
  def lower_half
    self[0..size / 2 - 1]
  end

  def upper_half
    self[size / 2..-1]
  end
end

class SeatCode
  def initialize(code)
    @code = code
    @row_code = code[0..6]
    @column_code = code[7..-1]
  end

  def row
    current_row = ROWS

    @row_code.each_char do |c|
      current_row =
        case c
        when 'F'
          current_row.lower_half
        when 'B'
          current_row.upper_half
        end
    end
    current_row.first
  end

  def column
    current_column = COLUMNS

    @column_code.each_char do |c|
      current_column =
        case c
        when 'R'
          current_column.upper_half
        when 'L'
          current_column.lower_half
        end
    end
    current_column.first
  end
end

codes = INPUT.map do |code|
  seat_code = SeatCode.new(code)
  seat_code.row * 8 + seat_code.column
end

all_ids = []

ROWS.each do |r|
  COLUMNS.each do |c|
    all_ids << r * 8 + c
  end
end

available_seats = (all_ids - codes)

my_seat_code = -1

# Found the first seat_code that not follow the sequence
available_seats.each_with_index do |seat_code, index|
  if available_seats[index + 1] != seat_code + 1
    my_seat_code = available_seats[index + 1]
    break
  end
end

p my_seat_code # => 669
