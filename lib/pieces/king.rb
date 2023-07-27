# frozen_string_literal: false

class King < Piece
  def initialize(color)
    super(color, '♚')
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, -1], [-1, -1], [-1, 1], [1, 1]]
  end

  def checked?(board, position)
    opponent_color = @color == 'blue' ? 'red' : 'blue'
    opponent_pieces = board.get_pieces(opponent_color)
    opponent_pieces.each do |piece|
      return true if piece.possible_moves(board).include?(position)
    end
    false
  end

  def possible_moves(board)
    all_possible_moves = super(board)
    all_possible_moves.reject { |move| checked?(board, move) }
  end
end
