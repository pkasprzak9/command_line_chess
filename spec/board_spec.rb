# frozen_string_literal: false

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
    it 'displays the chessboard with correctly allocated pieces'
  end
end
