# frozen_string_literal: false

# rubocop:disable Lint/MissingCopEnableDirective, Naming/AccessorMethodName

module UserInterface
  def set_name(player)
    puts "#{player}, please enter your name:"
    loop do
      name = gets.chomp
      return name if valid_name?(name)

      puts 'Invalid name, please try again.'
    end
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
      next if get_piece(possible_move).is_a?(King)

      x, y = possible_move
      temps[[x, y]] = @chessboard[x][y]
      circle = "#{color}●\e[0m"
      @chessboard[x][y] = circle
    end
    display_chessboard
    restore_chessboard(temps)
  end

  private

  def valid_name?(name)
    !name.empty?
  end
end
