# frozen_string_literal: false

require_relative '../lib/board'

board = Board.new
board.chessboard[0][0] = '♖'
board.chessboard[0][7] = '♖'
board.chessboard[0][1] = '♘'
board.chessboard[0][6] = '♘'
board.chessboard[0][2] = '♗'
board.chessboard[0][5] = '♗'
board.chessboard[0][3] = '♕'
board.chessboard[0][4] = '♔'
board.chessboard[1].map! { '♙' }
board.display_chessboard
