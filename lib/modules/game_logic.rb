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

  def mate?(board, piece)
    position = board.get_position(piece)
    return false unless piece.checked?(board, position)

    possible_moves = piece.possible_moves(board)
    possible_moves.each do |move|
      return false unless piece.checked?(board, move)
    end
    true unless defend_king?(board, piece)
    false
  end

  private

  def defend_king?(board, piece)
    checking_piece = get_checking_pieces(board, piece)
    my_pieces = board.get_pieces(piece.color)
    checking_squares = get_checking_squares(board, piece)
    my_pieces.each do |my_piece|
      next if my_piece == piece

      return true if my_piece.possible_moves(board).include?(board.get_position(checking_piece)) && checking_squares.include?(board.get_position(my_piece))
    end
    false
  end

  def get_checking_squares(board, piece)
    checking_piece = get_checking_pieces(board, piece)
    temp_position = board.get_position(checking_piece)
    checking_squares = []
    checking_squares << board.get_position(checking_piece)
    direction = [temp_position[0] - board.get_position(piece)[0], temp_position[1] - board.get_position(piece)[1]]
    direction[0] = direction[0].positive? ? 1 : -1 if direction[0] != 0
    direction[1] = direction[1].positive? ? 1 : -1 if direction[1] != 0
    checking_piece.possible_moves(board).each do |move|
      next unless move[0] == temp_position[0] + direction[0] && move[1] == temp_position[1] + direction[1]

      move(checking_piece, move)
      checking_squares << move if piece.checked?(board, board.get_position(piece))
      move(checking_piece, temp_position)
    end
    checking_squares
  end

  def get_checking_pieces(board, piece)
    opponent_color = piece.color == 'blue' ? 'red' : 'blue'
    opponent_pieces = board.get_pieces(opponent_color)
    position = board.get_position(piece)
    opponent_pieces.each do |opponent_piece|
      return opponent_piece if opponent_piece.possible_moves(board).include?(position)
    end
  end

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
