# frozen_string_literal: false

# rubocop:disable Lint/MissingCopEnableDirective, Naming/AccessorMethodName

module UserInterface
  def set_name(player)
    input("#{player}, please enter your name: ")
    loop do
      name = gets.chomp
      return name if valid_name?(name)

      error('Invalid name, please try again.')
    end
  end

  # DISPLAY MESSAGE METHODS

  def display_welcome_message
    message = <<~HEREDOC
      Welcome to Chess!
      This is a two-player game.
      You'll be asked to enter your names and then you can start playing.
    HEREDOC
    message(message)
  end

  def display_turn_info(player)
    message("#{player.name}, it's your turn!")
    input('Select a piece to move: ')
  end

  def display_promotion_menu
    input("Choose a piece to promote your pawn:\n1. Queen\n2. Rook\n3. Bishop\n4. Knight\n")
  end

  def display_invalid_piece
    error('Invalid piece, please try again.')
  end

  def display_piece_cannot_move
    error('This piece cannot move, please try again.')
  end

  def display_invalid_square(positions)
    error("Invalid position, please try again.\n Valid positions: #{positions.join(', ')}")
  end

  def display_select_position_message(piece)
    message("Select a square to move #{piece.class}")
  end

  def display_check_message(player)
    error("#{player.name}, you're in check!\nYou must move your king out of check.")
  end

  # BOARD DISPLAY METHODS

  # This method prints the possible moves of a piece in chessnotation.
  def print_possible_moves(board)
    moves = possible_moves(board)
    moves.map! do |move|
      translate_to_chessnotation(move)
    end
    p moves
  end

  def display_chessboard
    number = 8
    letters = %w[A B C D E F G H]
    colors = %i[white black]
    chessboard.each do |chessboard_row|
      print "#{number} "
      chessboard_row.each do |chessboard_cell|
        if chessboard_cell == ''
          send(colors.first, '   ')
        else
          send(colors.first, " #{chessboard_cell} ")
        end
        colors.rotate!
      end
      number -= 1
      colors.rotate!
      puts
    end
    puts "   #{letters.join('  ')}"
  end

  def display_possible_moves(possible_moves, color)
    pastel = Pastel.new
    color = pastel.lookup(color.to_sym)
    temps = {}
    possible_moves.each do |possible_move|
      next if @board.get_piece(possible_move).is_a?(King)

      x, y = possible_move
      temps[[x, y]] = @board.chessboard[x][y]
      circle = "#{color}●\e[0m"
      @board.chessboard[x][y] = circle
    end
    @board.display_chessboard
    @board.restore_chessboard(temps)
  end

  private

  def valid_name?(name)
    !name.empty?
  end

  def message(message)
    puts Pastel.new.blue.bold(message)
  end

  def error(message)
    puts Pastel.new.red.bold(message)
  end

  def input(message)
    puts Pastel.new.green.bold(message)
  end
end
