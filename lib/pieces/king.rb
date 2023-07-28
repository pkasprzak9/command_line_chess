# frozen_string_literal: false

class King < Piece
  def initialize(color)
    super(color, '♚')
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, -1], [-1, -1], [-1, 1], [1, 1]]
  end

  def possible_moves(board, check_for_checks: true)
    all_possible_moves = super(board)
    return all_possible_moves unless check_for_checks

    all_possible_moves.reject do |move|
      checked?(board, move)
    end
  end

  def checked?(board, position)
    opponent_color = @color == :red ? 'blue' : 'red'
    opponent_pieces = board.get_pieces(opponent_color)
    opponent_pieces.each do |piece|
      next if piece.is_a?(King)
      return true if piece.possible_moves(board, check_for_checks: false).include?(position)
    end
    false
  end

  def checked_by_opponent_king?(board, position)
    opponent_color = @color == :blue ? 'red' : 'blue'
    opponent_king = board.get_pieces(opponent_color).find { |piece| piece.is_a?(King) }
    opponent_king.possible_moves(board).include?(position)
  end
end
