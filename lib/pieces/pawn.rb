# frozen_string_literal: false

class Pawn < Piece
  def initialize(color)
    super(color, '♟')
    @moves = [[1, 0], [2, 0], [1, 1], [1, -1], [-1, 0], [-2, 0], [-1, 1], [-1, -1]]
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      possible_moves << [x, y] if board.valid_position?(x, y)
    end
    possible_moves
  end
end
