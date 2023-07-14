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

  def to_s
    @figure
  end
end
