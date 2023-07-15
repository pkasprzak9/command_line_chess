# frozen_string_literal: false

class King < Piece
  def initialize(color)
    super(color, '♚')
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, -1], [-1, -1], [-1, 1], [1, 1]]
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      possible_moves << temp_position if board.valid_position?(temp_position)
    end
    possible_moves
  end
end
