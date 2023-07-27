# frozen_string_literal: false

module GameLogic
  def translate_from_chessnotation(position)
    return unless valid_chessnotation?(position)

    position = position.split('')
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

  def select_piece_by_position(player)
    color = player.color
    position = gets.chomp

    return unless valid_chessnotation?(position)

    position = translate_from_chessnotation(position)
    return unless position

    piece = @board.get_piece(position)
    return unless piece

    return unless piece.color == color

    piece
  end

  def select_square_by_position(piece)
    possible_moves = piece.possible_moves(@board)
    position = gets.chomp

    return unless valid_chessnotation?(position)

    position = translate_from_chessnotation(position)
    return unless position

    return unless possible_moves.include?(position)

    position
  end

  def move(piece, position)
    possible_moves = piece.possible_moves(@board)
    return unless possible_moves.include?(position)

    if @board.occupied_by_opponent?(piece, position)
      capture(piece, position)
    else
      move_piece(piece, position)
    end
    piece.first_move = false
    (promote_pawn(piece) if pawn_promotion?(piece)) if piece.is_a?(Pawn)
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

  def mate?(player)
    piece = @board.get_king(player.color)
    position = @board.get_position(piece)
    return false unless piece.checked?(@board, position)

    possible_moves = piece.possible_moves(@board)
    possible_moves.each do |move|
      return false unless piece.checked?(@board, move)
    end
    true unless defend_king?(@board, piece)
    false
  end

  def castling(piece)
    king = piece
    king_approved_positions = [[0, 4], [7, 4]]
    king_position = @board.get_position(king)
    return unless castling?(king) && king_approved_positions.include?(king_position)

    rook = @board.get_piece([king_position[0], king_position[1] + 3])
    rook_position = @board.get_position(rook)
    @board.remove_piece(king_position)
    @board.remove_piece(rook_position)
    @board.set_piece(king, [king_position[0], king_position[1] + 2])
    @board.set_piece(rook, [rook_position[0], rook_position[1] - 2])
  end

  private

  def castling?(piece)
    king = piece
    king_position = @board.get_position(king)
    empty_positions = [[king_position[0], king_position[1] + 1], [king_position[0], king_position[1] + 2]]
    return false unless [[0, 4], [7, 4]].include?(king_position)

    return false if king.checked?(@board, [king_position[0], king_position[1] + 2]) || king.checked?(@board, [king_position[0], king_position[1] + 1])

    return false unless empty_positions.all? { |position| @board.chessboard[position[0]][position[1]] == '' }

    rook = @board.get_piece([king_position[0], king_position[1] + 3])
    return false unless king.first_move == true && rook.first_move == true

    true
  end

  def defend_king?(board, piece)
    checking_piece = get_checking_piece(board, piece)
    my_pieces = board.get_pieces(piece.color)
    checking_squares = get_checking_squares(board, piece)
    my_pieces.each do |my_piece|
      next if my_piece == piece

      piece_can_move_to_checking_piece = my_piece.possible_moves(board).include?(board.get_position(checking_piece))
      piece_is_on_checking_square = checking_squares.include?(board.get_position(my_piece))

      return true if piece_can_move_to_checking_piece || piece_is_on_checking_square
    end
    false
  end

  def get_checking_squares(board, piece)
    checking_piece = get_checking_piece(board, piece)
    checking_piece_position = board.get_position(checking_piece)
    checking_squares = []
    checking_squares << board.get_position(checking_piece)
    direction = calculate_direction(board, piece, checking_piece_position)
    checking_piece.possible_moves(board).each do |move|
      next_move_position = [checking_piece_position[0] + direction[:row], checking_piece_position[1] + direction[:col]]

      next unless move == next_move_position

      move(checking_piece, move)
      checking_squares << move if piece.checked?(board, board.get_position(piece))
      move(checking_piece, checking_piece_position)
    end
    checking_squares
  end

  def calculate_direction(board, piece, checking_piece_position)
    direction_row = checking_piece_position[0] - board.get_position(piece)[0]
    direction_col = checking_piece_position[1] - board.get_position(piece)[1]

    direction_row = direction_row.positive? ? 1 : -1 if direction_row != 0
    direction_col = direction_col.positive? ? 1 : -1 if direction_col != 0

    { row: direction_row, col: direction_col }
  end

  def get_checking_piece(board, piece)
    opponent_color = piece.color == 'blue' ? 'red' : 'blue'
    opponent_pieces = board.get_pieces(opponent_color)
    position = board.get_position(piece)
    opponent_pieces.each do |opponent_piece|
      return opponent_piece if opponent_piece.possible_moves(board).include?(position)
    end
  end

  def valid_chessnotation?(position)
    position.match?(/^[A-Ha-h][1-8]$/)
  end

  def move_piece(piece, position)
    piece_position = @board.get_position(piece)
    @board.remove_piece(piece_position)
    @board.set_piece(piece, position)
  end

  def pawn_promotion?(piece)
    position = @board.get_position(piece)
    approved_rows = [0, 7]
    true if approved_rows.include?(position[0])
  end

  def promote_pawn(pawn)
    position = @board.get_position(pawn)
    figures = { '1' => 'Queen', '2' => 'Rook', '3' => 'Bishop', '4' => 'Knight' }
    display_promotion_menu
    figure = verify_input(gets.chomp, figures.keys)
    figure = figures[figure]
    @board.remove_piece(position)
    figure = Piece.create(pawn.color, figure)
    @board.set_piece(figure, position)
  end

  def verify_input(input, verified_input)
    loop do
      return input if verified_input.include?(input)

      error('Invalid input, please try again.')
      input = gets.chomp
    end
  end
end
