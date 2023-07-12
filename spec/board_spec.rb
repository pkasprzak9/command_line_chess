# frozen_string_literal: false

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Layout/LineLength

require 'colorize'
require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    it 'creates a new chessboard' do
      chessboard = Array.new(8) { Array.new(8, '') }
      expect(Board.new.chessboard).to eq(chessboard)
    end
  end

  describe '#display_chessboard' do
    context 'when the chessboard is empty' do
      subject(:board) { Board.new }
      it 'displays the empty chessboard' do
        lb = '   '.colorize(background: :light_black)
        lw = '   '.colorize(background: :light_white)
        cells = "#{lb}#{lw}#{lb}#{lw}#{lb}#{lw}#{lb}#{lw}\n#{lw}#{lb}#{lw}#{lb}#{lw}#{lb}#{lw}#{lb}\n"
        chessboard = cells + cells + cells + cells
        expect { board.display_chessboard }.to output(chessboard).to_stdout
      end
    end

    context 'when the chessboard is not empty' do
      # rubocop:disable Style/StringConcatenation
      def create_row(*cells)
        cells.join + "\n"
      end
      # rubocop:enable Style/StringConcatenation

      subject(:board) { Board.new }
      let(:light_black_cell) { '   '.colorize(background: :light_black) }
      let(:light_white_cell) { '   '.colorize(background: :light_white) }
      let(:knight_cell) { ' ♞ '.colorize(background: :light_black) }
      it 'displays the chessboard with correctly allocated pieces' do
        board.chessboard[0][0] = '♞'
        row1 = create_row(knight_cell, light_white_cell, light_black_cell, light_white_cell, light_black_cell, light_white_cell, light_black_cell, light_white_cell)
        row2 = create_row(light_white_cell, light_black_cell, light_white_cell, light_black_cell, light_white_cell, light_black_cell, light_white_cell, light_black_cell)
        row3 = create_row(light_black_cell, light_white_cell, light_black_cell, light_white_cell, light_black_cell, light_white_cell, light_black_cell, light_white_cell)

        expected_output = row1 + row2 + row3 + row2 + row3 + row2 + row3 + row2

        expect { board.display_chessboard }.to output(expected_output).to_stdout
      end
    end
  end
end
