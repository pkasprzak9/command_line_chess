# frozen_string_literal: false

class Rook < Piece
  def initialize(color)
    super(color, '♜')
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      x, y = position
      multiplier = 1
      while board.valid_position?(x, y)
        x = position[0] + (move[0] * multiplier)
        y = position[1] + (move[1] * multiplier)
        multiplier += 1
        possible_moves << [x, y] if board.valid_position?(x, y)
      end
    end
    possible_moves
  end
end
