# frozen_string_literal: false

# rubocop:disable Lint/MissingCopEnableDirective

require 'colorize'
require 'pastel'

class Board
  attr_accessor :chessboard, :first_player_color

  def initialize
    @chessboard = Array.new(8) { Array.new(8, '') }
    @first_player_color = nil
  end

  def display_chessboard
    number = 8
    letters = %w[a b c d e f g h]
    colors = %i[black white]
    chessboard.each do |chessboard_row|
      print "#{number} "
      chessboard_row.each do |chessboard_cell|
        if chessboard_cell == ''
          send(colors.first, '   ')
        else
          send(colors.first, " #{chessboard_cell} ")
        end
        colors.rotate!
      end
      number -= 1
      colors.rotate!
      puts
    end
    puts "   #{letters.join('  ')}"
  end

  def set_piece(piece, position)
    x, y = position
    if valid_position?(position)
      @chessboard[x][y] = piece
      true
    else
      false
    end
  end

  def remove_piece(position)
    if valid_position?(position)
      x, y = position
      @chessboard[x][y] = ''
      true
    else
      false
    end
  end

  def get_piece(position)
    x, y = position
    @chessboard[x][y] if valid_position?(position)
  end

  def get_position(piece)
    @chessboard.each_with_index do |chessboard_row, x|
      chessboard_row.each_with_index do |chessboard_cell, y|
        return [x, y] if chessboard_cell == piece
      end
    end
    nil
  end

  def valid_position?(position)
    x, y = position
    x.between?(0, 7) && y.between?(0, 7)
  end

  def occupied_by_opponent?(piece, position)
    x, y = position
    @chessboard[x][y] != '' && @chessboard[x][y].color != piece.color
  end

  def occupied_by_friendly?(piece, position)
    x, y = position
    @chessboard[x][y] != '' && @chessboard[x][y].color == piece.color
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
