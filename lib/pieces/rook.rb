# frozen_string_literal: false

class Rook < SlidingPiece
  def initialize(color)
    super(color, '♜')
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end
end
