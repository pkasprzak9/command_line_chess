# frozen_string_literal: false

require_relative '../lib/game'

describe Game do
  describe '#translate_chessnotation' do
    subject(:game) { described_class.new }
    context 'when given a valid chess notation' do
      context 'when given a capital letter' do
        it 'returns the correct array' do
          allow(game).to receive(:valid_chessnotation?).and_return(true)
          position = 'A1'
          result = [1, 0]
          expect(game.translate_chessnotation(position)).to eq(result)
        end
      end

      context 'when given a lowercase letter' do
        it 'returns the correct array' do
          allow(game).to receive(:valid_chessnotation?).and_return(true)
          position = 'a1'
          result = [1, 0]
          expect(game.translate_chessnotation(position)).to eq(result)
        end
      end
    end

    context 'when given an invalid chess notation' do
      it 'returns nil' do
        allow(game).to receive(:valid_chessnotation?).and_return(false)
        position = 'A9'
        expect(game.translate_chessnotation(position)).to be_nil
      end
    end
  end
end
