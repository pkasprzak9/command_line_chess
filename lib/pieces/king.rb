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
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      next if board.valid_position?(temp_position) && board.occupied_by_friendly?(self, temp_position) || checked?(board, temp_position)

      possible_moves << temp_position if board.valid_position?(temp_position)
    end
    possible_moves
  end
end
