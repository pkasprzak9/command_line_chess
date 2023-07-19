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

  private

  def valid_name?(name)
    !name.empty?
  end
end
