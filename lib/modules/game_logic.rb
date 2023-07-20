# frozen_string_literal: false

module GameLogic
  def translate_chessnotation(position)
    position = position.split('')
    return unless valid_chessnotation?(position)

    col = position[0]
    row = 8 - position[1].to_i
    col = /[[:upper:]]/.match(col) ? (col.ord - 65) : (col.ord - 97)

    [row, col] if @board.valid_position?([row, col])
  end

  def move(piece, position)
    position = translate_chessnotation(position)
    return unless position

    possible_moves = piece.possible_moves(@board)
    move_piece(piece, position) if possible_moves.include?(position)
  end

  private

  def valid_chessnotation?(position)
    if position.length == 2 && (position[0].match?(/[A-H]/) || position[0].match?(/[a-h]/)) && position[1].match?(/[1-8]/)
      true
    end
  end

  def move_piece(piece, position)
    piece_position = @board.get_position(piece)
    @board.remove_piece(piece_position)
    @board.set_piece(piece, position)
  end
end
