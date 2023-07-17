# frozen_string_literal: false

class SlidingPiece < Piece
  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      possible_moves += calculate_moves_for_direction(board, position, move)
    end
    possible_moves
  end

  def calculate_moves_for_direction(board, position, move)
    possible_moves_for_direction = []
    temp_position = position
    multiplier = 1
    while board.valid_position?(temp_position)
      x = position[0] + (move[0] * multiplier)
      y = position[1] + (move[1] * multiplier)
      temp_position = [x, y]
      break if board.valid_position?(temp_position) && board.occupied_by_friendly?(self, temp_position)

      multiplier += 1
      possible_moves_for_direction << temp_position if board.valid_position?(temp_position)
    end
    possible_moves_for_direction
  end
end
