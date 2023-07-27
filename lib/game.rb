# frozen_string_literal: false

require_relative 'libraries'
require_relative 'board'
require_relative 'piece'
require_relative 'modules/game_logic'
require_relative 'modules/user_interface'
require 'pry-byebug'

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
  end

  def play
    display_welcome_message
    prepare_game
    until @winner
      players.each do |player|
        board.display_chessboard
        player_turn(player)
        break if mate?(player)
      end
    end
  end

  def player_turn(player)
    loop do
      display_turn_info(player)
      piece = select_piece(player)
      display_possible_moves(piece.possible_moves(board), player.color)
      position = select_square(piece)
      move(piece, position)
      king = @board.get_king(player.color)
      break unless king.checked?(@board, @board.get_position(king))

      x, y = @board.get_position(piece)
      @board.chessboard[x, y] = piece
      display_check_message(player)
    end
  end
end
