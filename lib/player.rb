# frozen_string_literal: false

class Player
  attr_reader :name, :color, :points

  def initialize(name, color)
    @name = name
    @color = color
    @points = 0
  end

  def update_points(points)
    @points += points
  end
end
