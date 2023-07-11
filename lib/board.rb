# frozen_string_literal: false

class Board
  attr_reader :chessboard

  def initialize
    @chessboard = Array.new(8) { Array.new(8, ' ') }
  end
end
