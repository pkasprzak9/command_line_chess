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

  def create_players(colors)
    @players << Player.new(set_name('Player 1'), colors[0])
    @players << Player.new(set_name('Player 2'), colors[1])
  end
end
