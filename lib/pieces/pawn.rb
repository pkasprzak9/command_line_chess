# frozen_string_literal: false

class Pawn < Piece
  def initialize(color)
    super(color, '♟')
    @moves = [[1, 0], [-1, 0]]
    @capturing_moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @first_moves = [[1, 0], [2, 0], [-1, 0], [-2, 0]]
    @first_move = true
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []

    moves = @first_move ? @first_moves : @moves
    possible_moves += calculate_moves(board, position, moves)
    possible_moves += calculate_capturing_moves(board, position)
    possible_moves
  end

  def calculate_moves(board, position, moves)
    moves_result = []
    moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      break if board.valid_position?(temp_position) && board.occupied_by_friendly?(self, temp_position)

      moves_result << temp_position if board.valid_position?(temp_position)
    end
    moves_result
  end

  def calculate_capturing_moves(board, position)
    capturing_moves_result = []
    @capturing_moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      if board.valid_position?(temp_position) && board.occupied_by_opponent?(self, temp_position)
        capturing_moves_result << temp_position
      end
    end
    capturing_moves_result
  end
end
