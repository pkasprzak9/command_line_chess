# frozen_string_literal: false

require 'pastel'
require_relative './board'

class Piece
  attr_reader :color, :figure, :moves

  def initialize(color, figure = nil, moves = nil)
    @color = color
    @figure = Pastel.new.send(color.to_sym, figure)
    @moves = moves
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
      possible_moves << temp_position if board.valid_position?(temp_position)
    end
    possible_moves
  end

  def to_s
    @figure
  end
end
