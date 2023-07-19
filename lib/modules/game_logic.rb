# frozen_string_literal: false

module GameLogic
  def translate_chessnotation(position)
    position = position.split('')
    return unless valid_chessnotation?(position)

    col = position[0]
    row = position[1]
    col = /[[:upper:]]/.match(col) ? (col.ord - 65) : (col.ord - 97)
    [row.to_i, col.to_i]
  end

  private

  def valid_chessnotation?(position)
    if position.length == 2 && (position[0].match?(/[A-H]/) || position[0].match?(/[a-h]/)) && position[1].match?(/[1-8]/)
      true
    end
  end
end
