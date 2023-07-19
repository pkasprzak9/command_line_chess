# frozen_string_literal: false

require_relative 'libraries'

class Game
  def initialize(board = Board.new)
    @board = board
    @players = []
  end
end
