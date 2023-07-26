# frozen_string_literal: false

require 'pastel'
require_relative './board'
require_relative './modules/game_logic'
require_relative './modules/user_interface'

class Piece
  include GameLogic
  include UserInterface

  attr_reader :color, :figure, :moves
  attr_accessor :first_move

  def initialize(color, figure = nil, moves = nil)
    @color = color
    @figure = Pastel.new.send(color.to_sym, figure)
    @moves = moves
    @first_move = true
  end

  def self.create(color, figure)
    klass = Object.const_get(figure.capitalize)
    klass.new(color)
  end

  def possible_moves(board)
    position = board.get_position(self)
    possible_moves = []
    @moves.each do |move|
      x, y = position
      x += move[0]
      y += move[1]
      temp_position = [x, y]
      next if board.valid_position?(temp_position) && board.occupied_by_friendly?(self, temp_position)

      possible_moves << temp_position if board.valid_position?(temp_position)
    end
    possible_moves
  end

  def to_s
    @figure
  end
end
