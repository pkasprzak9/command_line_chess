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
  attr_accessor :winner

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
        break if @winner
      end
    end
    board.display_chessboard
    display_end_game_message(@winner)
  end

  # I know this method is too long, but so far I haven't found a way to make it
  # shorter. I tried to split it into smaller methods, but every time it
  # changed the logic of the game. I'll try to refactor it later.
  def player_turn(player)
    display_turn_info(player)
    temp = board.chessboard.map(&:clone)
    loop do
      king = board.get_king(player.color)
      if king.checked?(board, board.get_position(king))
        display_check_message(player)
        piece = select_piece(player)
        display_possible_moves(piece.possible_moves(board), player.color)
        position = select_square(piece)
        move(piece, position)
      else
        piece = select_piece(player)
        display_possible_moves(piece.possible_moves(board), player.color)
        position = select_square(piece)
        move(piece, position)
        piece.first_move = false
      end
      if king.checked?(board, board.get_position(king))
        display_move_not_allowed_message
        board.chessboard = temp
        board.display_chessboard
      else
        piece.first_move = false
        break
      end
    end
    @winner = player if mate?(@players[1 - @players.index(player)])
  end
end
