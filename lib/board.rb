# frozen_string_literal: false

require 'colorize'

class Board
  attr_reader :chessboard

  def initialize
    @chessboard = Array.new(8) { Array.new(8, '') }
  end

  def display_chessboard
    colors = %i[light_black light_white]
    chessboard.each do |chessboard_row|
      chessboard_row.each do |chessboard_cell|
        if chessboard_cell == ''
          print '   '.colorize(background: colors[0])
          colors.rotate!
        end
      end
      colors.rotate!
      puts
    end
  end
end

