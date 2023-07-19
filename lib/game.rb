# frozen_string_literal: false

require_relative 'libraries'
require_relative 'modules/game_logic'

class Game
  include GameLogic

  def initialize(board = Board.new)
    @board = board
    @players = []
  end
end
