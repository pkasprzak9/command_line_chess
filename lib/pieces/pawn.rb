# frozen_string_literal: false

class Pawn < Piece
  def initialize(color)
    super(color, '♟')
    @moves = [[-1, 0]]
    @capturing_moves = [[-1, 1], [-1, -1]]
    @first_moves = [[-1, 0], [-2, 0]]
    @first_move = true
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    moves = @first_move ? @first_moves : @moves
    moves = assign_direction(moves, board)
    possible_moves += calculate_moves(board, position, moves)
    possible_moves += calculate_capturing_moves(board, position)
    possible_moves
  end

  def assign_direction(moves, board)
    first_player_color = board.first_player_color
    piece_color = @color
    return moves if first_player_color == piece_color

    moves.map! { |move| [-move[0], move[1]] }
  end

  def calculate_moves(board, position, moves)
    moves_result = []
    moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      break if board.valid_position?(temp_position) && board.occupied?(temp_position)

      moves_result << temp_position if board.valid_position?(temp_position)
    end
    moves_result
  end

  def calculate_capturing_moves(board, position)
    capturing_moves_result = []
    capturing_moves = assign_direction(@capturing_moves, board)
    capturing_moves.each do |move|
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
