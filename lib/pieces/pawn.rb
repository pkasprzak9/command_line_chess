# frozen_string_literal: false

class Pawn < Piece
  def initialize(color)
    super(color, '♟')
    @moves = [[1, 0], [2, 0], [1, 1], [1, -1]]
  end
end
