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

  # This method prints the possible moves of a piece in chessnotation.
  def print_possible_moves(board)
    moves = possible_moves(board)
    moves.map! do |move|
      translate_to_chessnotation(move)
    end
    p moves
  end

  private

  def valid_name?(name)
    !name.empty?
  end
end
