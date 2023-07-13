# frozen_string_literal: false

# rubocop:disable Lint/MissingCopEnableDirective

require 'colorize'
require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    it 'creates a new chessboard' do
      chessboard = Array.new(8) { Array.new(8, '') }
      expect(Board.new.chessboard).to eq(chessboard)
    end
  end

  describe '#set_piece' do
    context 'when the position is valid' do
      subject(:board) { described_class.new }
      let(:piece) { double('piece') }
      before do
        allow(board).to receive(:valid_position?).and_return(true)
      end
      it 'sets the piece on the chessboard' do
        position = [0, 0]
        board.set_piece(piece, position)
        expect(board.chessboard[0][0]).to eq(piece)
      end

      it 'returns true' do
        position = [0, 0]
        expect(board.set_piece(piece, position)).to be true
      end
    end

    context 'when the position is invalid' do
      subject(:board) { described_class.new }
      let(:piece) { double('piece') }
      before do
        allow(board).to receive(:valid_position?).and_return(false)
      end
      it 'does not set the piece on the chessboard' do
        position = [0, 0]
        board.set_piece(piece, position)
        expect(board.chessboard[0][0]).to eq('')
      end
      it 'returns false' do
        position = [0, 0]
        expect(board.set_piece(piece, position)).to be false
      end
    end
  end

  describe '#get_piece' do
    subject(:board) { described_class.new }
    let(:piece) { double('piece') }

    context 'when the position is valid' do
      it 'returns the piece on the chessboard' do
        allow(board).to receive(:valid_position?).and_return(true)
        position = [0, 0]
        board.set_piece(piece, position)
        expect(board.get_piece(position)).to eq(piece)
      end
    end

    context 'when the position is invalid' do
      it 'returns nil' do
        allow(board).to receive(:valid_position?).and_return(false)
        position = [0, 0]
        board.set_piece(piece, position)
        expect(board.get_piece(position)).to be nil
      end
    end

    describe 'remove_piece' do
      context 'when the position is valid' do
        subject(:board) { described_class.new }
        let(:piece) { double('piece') }
        let(:position) { [0, 0] }
        before do
          allow(board).to receive(:valid_position?).and_return(true)
          board.set_piece(piece, position)
        end
        it 'removes the piece from the chessboard' do
          x, y = position
          board.remove_piece(position)
          expect(board.chessboard[x][y]).to eq('')
        end

        it 'returns true' do
          expect(board.remove_piece(position)).to be true
        end
      end

      context 'when the position is invalid' do
        subject(:board) { described_class.new }
        let(:piece) { double('piece') }
        let(:position) { [0, 0] }
        before do
          allow(board).to receive(:valid_position?).and_return(true, false)
          board.set_piece(piece, position)
        end

        it 'does not remove the piece from the chessboard' do
          x, y = position
          board.remove_piece(position)
          expect(board.chessboard[x][y]).to eq(piece)
        end

        it 'returns false' do
          expect(board.remove_piece(position)).to be false
        end
      end
    end
  end
end
