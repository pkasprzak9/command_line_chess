# frozen_string_literal: false

class Bishop < SlidingPiece
  def initialize(color)
    super(color, '♝')
    @moves = [[1, 1], [-1, -1], [-1, 1], [1, -1]]
  end
end
