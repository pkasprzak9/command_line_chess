# frozen_string_literal: false

class Pawn < Piece
  def initialize(color)
    super(color, '♟')
    @moves = [[1, 0], [2, 0], [-1, 0], [-2, 0]]
    @capturing_moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def possible_moves(board)
    possible_moves = super(board)
    position = board.get_position(self)
    @capturing_moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      if board.valid_position?(temp_position) && board.occupied_by_opponent?(self, temp_position)
        possible_moves << temp_position
      end
    end
    possible_moves
  end
end
