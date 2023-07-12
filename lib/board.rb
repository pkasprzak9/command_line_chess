# frozen_string_literal: false

require 'colorize'
require 'pastel'

class Board
  attr_accessor :chessboard

  def initialize
    @chessboard = Array.new(8) { Array.new(8, '') }
  end

  def display_chessboard
    colors = %i[black white]
    chessboard.each do |chessboard_row|
      chessboard_row.each do |chessboard_cell|
        if chessboard_cell == ''
          send(colors.first, '   ')
        else
          send(colors.first, " #{chessboard_cell} ")
        end
        colors.rotate!
      end
      colors.rotate!
      puts
    end
  end

  private

  def black(input)
    pastel = Pastel.new
    print pastel.on_black(input)
  end

  def white(input)
    pastel = Pastel.new
    print pastel.on_white(input)
  end
end
