# frozen_string_literal: false

require_relative '../lib/game'

describe Game do
  describe '#translate_from_chessnotation' do
    subject(:game) { described_class.new }
    context 'when given a valid chess notation' do
      context 'when given a capital letter' do
        it 'returns the correct array' do
          allow(game).to receive(:valid_chessnotation?).and_return(true)
          position = 'A8'
          result = [0, 0]
          expect(game.translate_from_chessnotation(position)).to eq(result)
        end
      end

      context 'when given a lowercase letter' do
        it 'returns the correct array' do
          allow(game).to receive(:valid_chessnotation?).and_return(true)
          position = 'a1'
          result = [7, 0]
          expect(game.translate_from_chessnotation(position)).to eq(result)
        end
      end
    end

    context 'when given an invalid chess notation' do
      it 'returns nil' do
        allow(game).to receive(:valid_chessnotation?).and_return(false)
        position = 'A9'
        expect(game.translate_from_chessnotation(position)).to be_nil
      end
    end
  end

  describe '#create_players' do
    let(:player1) { double('Player', name: 'Player 1', color: 'white') }
    let(:player2) { double('Player', name: 'Player 2', color: 'black') }
    subject(:game) { described_class.new }

    context 'when entering valid names' do
      before do
        colors = %w[white black]
        allow(game).to receive(:set_name).and_return('Player 1', 'Player 2')
        game.create_players(colors)
      end

      it 'creates two players with given names' do
        expect(game.players[0].name).to eq(player1.name)
        expect(game.players[1].name).to eq(player2.name)
      end

      it 'correctly assigns colors to players' do
        expect(game.players[0].color).to eq(player1.color)
        expect(game.players[1].color).to eq(player2.color)
      end
    end
  end

  describe '#set_name' do
    subject(:game) { described_class.new }
    before do
      allow(game).to receive(:puts)
    end
    context 'when given a valid name' do
      it 'returns the name' do
        allow(game).to receive(:gets).and_return('Player 1')
        error_message = 'Invalid name, please try again.'
        expect(game).not_to receive(:puts).with(error_message)
        game.set_name('Player 1')
      end
    end

    context 'when given an invalid name twice and the valid' do
      it 'display the error message twice' do
        allow(game).to receive(:gets).and_return('', '', 'Player 1')
        error_message = 'Invalid name, please try again.'
        expect(game).to receive(:puts).with(error_message).twice
        game.set_name('Player 1')
      end
    end
  end

  describe '#move' do
    subject(:game) { described_class.new }
    let(:board) { instance_double(Board) }
    let(:piece) { instance_double(Piece) }
    before do
      game.instance_variable_set(:@board, board)
    end
    context 'when given a valid position' do
      before do
        allow(piece).to receive(:first_move=).and_return(false)
        allow(game).to receive(:translate_from_chessnotation).and_return([0, 0])
        allow(piece).to receive(:possible_moves).and_return([[0, 0]])
        allow(board).to receive(:get_position).and_return([0, 0])
        allow(board).to receive(:remove_piece)
        allow(board).to receive(:set_piece)
        allow(board).to receive(:occupied_by_opponent?).and_return(false)
      end

      it 'gets the possible moves of the piece' do
        game.move(piece, [0, 0])
        expect(piece).to have_received(:possible_moves).with(board)
      end

      it 'removes the piece from its current position' do
        game.move(piece, [0, 0])
        expect(board).to have_received(:remove_piece).with([0, 0])
      end

      it 'sets the piece at the new position' do
        game.move(piece, [0, 0])
        expect(board).to have_received(:set_piece).with(piece, [0, 0])
      end
    end
  end
end
