# frozen_string_literal: false

require_relative 'libraries'
require_relative 'board'
require_relative 'piece'
require_relative 'modules/game_logic'
require_relative 'modules/user_interface'

class Game
  include GameLogic
  include UserInterface

  attr_reader :players, :board

  COLORS = %i[red blue].freeze

  def initialize(board = Board.new)
    @board = board
    @winner = nil
    @players = []
  end

  def create_players(colors = COLORS)
    @players << Player.new(set_name('Player 1'), colors[0])
    @players << Player.new(set_name('Player 2'), colors[1])
  end

  def prepare_game
    create_players
    board.prepare_chessboard(players.map(&:color))
    board.display_chessboard
  end

  def play
    display_welcome_message
    prepare_game
    loop do
      players.each do |player|
        player_turn(player)
        break if mate?(player)

        board.display_chessboard
      end
    end
  end

  def player_turn(player)
    display_turn_info(player)
    piece = select_piece(player)
    display_possible_moves(piece.possible_moves(board), player.color)
    position = select_square(piece)
    move(piece, position)
  end

  def select_piece(player)
    loop do
      piece = select_piece_by_position(player)
      if piece.nil?
        display_invalid_piece
      else
        possible_moves = piece.possible_moves(board)
        return piece if piece && !possible_moves.empty?

        display_piece_cannot_move if possible_moves.empty?
      end
    end
  end

  def select_square(piece)
    display_select_position_message(piece)
    loop do
      square = select_square_by_position(piece)
      return square if square

      positions = piece.possible_moves(board)
      positions.map! { |position| translate_to_chessnotation(position) }

      display_invalid_square(positions)
    end
  end
end
