class Sudoku
  attr_reader :board, :numbers

  def initialize(board)
    @board = board
    @numbers = 1.upto(9).to_a
  end

  # Find an empty spot
  # Given the numbers @numbers
  #   Iterate through each
  #     Is this number valid in this spot?
  #       We place the number in the spot
  #       Otherwise, we go to the next number
  def solve
    coords = find_empty
    x, y = coords

    return board unless coords

    numbers.each do |number|
      if is_valid?(number: number, x: x, y: x)
        board[y][x] = number

        if solve
          return board
        end

        board[y][x] = 0
      end
    end

    false
  end

  def find_empty
    board.each_with_index do |row, y_idx|
      x_idx = row.find_index(&:zero?)
      return [x_idx, y_idx] if x_idx
    end
    nil
  end

  def is_valid?(number:, x:, y:)
    !in_row?(number: number, y: y) &&
    !in_col?(number: number, x: x) &&
    !in_block?(number: number, x: x, y: y)
  end

  def in_row?(number:, y:)
    board[y].include?(number)
  end

  def in_col?(number:, x:)
    board.each do |row|
      return true if row[x] == number
    end
    false
  end

  def in_block?(number:, x:, y:)
    x_start = x - x % 3
    y_start = y - y % 3

    y_start.upto(y_start + 2) do |y_idx|
      x_start.upto(x_start + 2) do |x_idx|
        return true if board[y_idx][x_idx] == number
      end
    end

    false
  end
end
