# frozen_string_literal: false

class Player
  attr_reader :name, :color, :first

  def initialize(name, color, first: false)
    @name = name
    @color = color
    @points = 0
    @first = first
  end

  def update_points(points)
    @points += points
  end
end
