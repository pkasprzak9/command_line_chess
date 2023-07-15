# frozen_string_literal: false

class Queen < Piece
  def initialize(color)
    super(color, '♛')
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, -1], [-1, -1], [-1, 1], [1, 1]]
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      temp_position = position
      multiplier = 1
      while board.valid_position?(temp_position)
        x = position[0] + (move[0] * multiplier)
        y = position[1] + (move[1] * multiplier)
        temp_position = [x, y]
        multiplier += 1
        possible_moves << temp_position if board.valid_position?(temp_position)
      end
    end
    possible_moves
  end
end
