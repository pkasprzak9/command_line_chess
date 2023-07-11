# frozen_string_literal: false

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    it 'creates a new chessboard' do
      chessboard = Array.new(8) { Array.new(8, ' ') }
      expect(Board.new.chessboard).to eq(chessboard)
    end
  end
end
