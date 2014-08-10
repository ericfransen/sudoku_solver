require_relative './sudoku'

describe Sudoku do
  it 'takes a board as an argument' do
    sudoku = Sudoku.new([])
    expect(sudoku.board).to eq []
  end

  context 'with a 9x9 board' do
    let(:board) {
      [
        [0, 8, 0],
        [0, 0, 7],
        [5, 0, 1]
      ]
    }

    let(:solution) {
      [
        [2, 8, 3],
        [4, 6, 7],
        [5, 9, 1]
      ]
    }

    let(:sudoku) { Sudoku.new(board) }

    describe '#solve' do
      it 'returns the solution' do
        expect(sudoku.solve).to eq solution
      end
    end

    describe '#is_valid?' do
      it 'returns true for a valid number placement' do
        result = sudoku.is_valid?(number: 2, x: 0, y: 0)
        expect(result).to be true
      end

      it 'returns false for an invalid number placement' do
        result = sudoku.is_valid?(number: 8, x: 0, y: 0)
        expect(result).to be false
      end
    end

    describe '#in_row?' do
      it 'returns false if the number does not exist in the current row' do
        result = sudoku.in_row?(number: 2, y: 0)
        expect(result).to be false
      end

      it 'returns true if the number exists in the current row' do
        result = sudoku.in_row?(number: 8, y: 0)
        expect(result).to be true
      end
    end

    describe '#in_col?' do
      it 'returns false if the number does not exist in the current col' do
        result = sudoku.in_col?(number: 2, x: 0)
        expect(result).to be false
      end

      it 'returns true if the number exists in the current col' do
        result = sudoku.in_col?(number: 5, x: 0)
        expect(result).to be true
      end
    end

    describe '#in_block?' do
      it 'returns false if the number does not exist in the current block' do
        result = sudoku.in_block?(number: 2, x: 0, y: 0)
        expect(result).to be false
      end

      it 'returns true if the number exists in the current block' do
        result = sudoku.in_block?(number: 8, x: 0, y: 0)
        expect(result).to be true
      end
    end

    describe '#find_empty' do
      it 'returns the coordinates for an available spot' do
        grid = [[1, 0], [2, 3]]
        sudoku = Sudoku.new(grid)
        expect(sudoku.find_empty).to eq [1, 0]
      end

      it 'return nil when no spot is available' do
        grid = [[1, 4], [2, 3]]
        sudoku = Sudoku.new(grid)
        expect(sudoku.find_empty).to be_nil
      end
    end
  end
end
