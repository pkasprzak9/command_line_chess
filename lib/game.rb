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
end
