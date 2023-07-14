# frozen_string_literal: false

require_relative '../lib/piece'
require_relative '../lib/pieces/king'
require 'pastel'

describe Piece do
  describe '#initialize' do
    piece = Piece.new('white', '♚')
    it 'creates a new piece' do
      expect(piece).to be_an_instance_of(Piece)
    end
    it 'has a color' do
      expect(piece.color).to eq('white')
    end
    it 'has a figure' do
      figure = Pastel.new.send('white'.to_sym, '♚')
      expect(piece.figure).to eq(figure)
    end
  end

  describe '#create' do
    context 'when the figure is king' do
      subject(:king) { described_class.create('white', 'king') }
      it 'creates a new piece' do
        expect(king).to be_an_instance_of(King)
      end
      it 'has a color' do
        expect(king.color).to eq('white')
      end
      it 'has an assigned figure' do
        figure = Pastel.new.send('white'.to_sym, '♚')
        expect(king.figure).to eq(figure)
      end
      it 'has a list of moves' do
        moves = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
        expect(king.moves).to include(*moves)
      end
    end
  end
end
