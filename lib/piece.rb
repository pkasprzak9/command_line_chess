# frozen_string_literal: false

class Piece
  attr_reader :color, :figure

  def initialize(color, figure = nil)
    @color = color
    @figure = figure
  end
end
