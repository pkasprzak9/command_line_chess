# frozen_string_literal: false

class Knight < Piece
  def initialize(color)
    super(color, '♞')
    @moves = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]
  end
end
