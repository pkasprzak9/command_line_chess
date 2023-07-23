# frozen_string_literal: false

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Metrics/ClassLength

require 'colorize'
require 'pastel'
require_relative 'piece'
require_relative 'modules/game_logic'
require_relative 'modules/user_interface'

class Board
  include GameLogic
  include UserInterface

  attr_accessor :chessboard, :first_player_color

  def initialize
    @chessboard = Array.new(8) { Array.new(8, '') }
    @first_player_color = nil
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

  def occupied?(position)
    x, y = position
    @chessboard[x][y] != ''
  end

  def occupied_by_opponent?(piece, position)
    x, y = position
    @chessboard[x][y] != '' && @chessboard[x][y].color != piece.color
  end

  def occupied_by_friendly?(piece, position)
    x, y = position
    @chessboard[x][y] != '' && @chessboard[x][y].color == piece.color
  end

  def prepare_chessboard(colors)
    @first_player_color = colors.first
    place_pawns(colors)
    place_figures(colors)
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

  def place_pawns(colors)
    @chessboard.each_with_index do |chessboard_row, x|
      chessboard_row.each_with_index do |_chessboard_cell, y|
        if x == 1
          set_piece(Piece.create(colors.last, 'pawn'), [x, y])
        elsif x == 6
          set_piece(Piece.create(colors.first, 'pawn'), [x, y])
        end
      end
    end
  end

  def place_figures(colors)
    figures = %w[rook knight bishop queen king bishop knight rook]
    @chessboard.each_with_index do |chessboard_row, x|
      chessboard_row.each_with_index do |_chessboard_cell, y|
        if x.zero?
          y = 0
          figures.each do |figure|
            set_piece(Piece.create(colors.last, figure), [x, y])
            y += 1
          end
        elsif x == 7
          y = 0
          figures.each do |figure|
            set_piece(Piece.create(colors.first, figure), [x, y])
            y += 1
          end
        end
      end
    end
  end

  def restore_chessboard(temps)
    temps.each do |position, piece|
      @chessboard[position[0]][position[1]] = piece
    end
  end
end
