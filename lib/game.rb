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
    display_turn_info(player)
    king = @board.get_king(player.color)
    if king.checked?(board, @board.get_position(king))
      end_game(player) if mate?(player)
      temp = @board.chessboard.map(&:clone)
      loop do
        display_check_message(player)
        piece = select_piece(player)
        display_possible_moves(piece.possible_moves(board), player.color)
        position = select_square(piece)
        move(piece, position)
        if king.checked?(board, @board.get_position(king))
          @board.chessboard = temp
        else
          piece.first_move = false
          break
        end
      end
    else
      piece = select_piece(player)
      display_possible_moves(piece.possible_moves(board), player.color)
      position = select_square(piece)
      move(piece, position)
      piece.first_move = false
    end
  end

  def end_game(player)
    @winner = player
    display_end_game_message(player)
  end
end
