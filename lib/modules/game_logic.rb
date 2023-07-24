# frozen_string_literal: false

module GameLogic
  def translate_from_chessnotation(position)
    position = position.split('')
    return unless valid_chessnotation?(position)

    col = position[0]
    row = 8 - position[1].to_i
    col = /[[:upper:]]/.match(col) ? (col.ord - 65) : (col.ord - 97)

    [row, col] if @board.valid_position?([row, col])
  end

  def translate_to_chessnotation(position)
    letters = ('A'..'H').to_a
    numbers = (1..8).to_a
    col = letters[position[1]]
    row = numbers[7 - position[0]]
    "#{col}#{row}"
  end

  def move(piece, position)
    possible_moves = piece.possible_moves(@board)
    return unless possible_moves.include?(position)

    if @board.occupied_by_opponent?(piece, position)
      capture(piece, position)
    else
      move_piece(piece, position)
    end
    piece.first_move = false if piece.is_a?(Pawn)
  end

  def capture(piece, position)
    opponent_piece = @board.get_piece(position)
    current_position = @board.get_position(piece)
    possible_moves = piece.possible_moves(@board)
    return unless possible_moves.include?(position) && @board.occupied_by_opponent?(piece, position)

    return if opponent_piece.is_a?(King)

    @board.remove_piece(position)
    @board.remove_piece(current_position)
    @board.set_piece(piece, position)
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
