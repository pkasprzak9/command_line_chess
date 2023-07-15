# frozen_string_literal: false

# rubocop:disable Metrics/AbcSize

class Pawn < Piece
  def initialize(color)
    super(color, '♟')
    @moves = [[1, 0], [2, 0], [-1, 0], [-2, 0]]
    @capturing_moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      temp_position = position
      x, y = temp_position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      possible_moves << temp_position if board.valid_position?(temp_position)
    end
    @capturing_moves.each do |move|
      temp_position = position
      x, y = temp_position
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
