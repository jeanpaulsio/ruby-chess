require 'colorize'
require 'colorized_string'

class Board
  attr_accessor :board

  def initialize
    @board   = Array.new(8){ Array.new(8) { "" } }
    @space   = "  "
    @cell    = "      "
    @w_row   = [ @space, 
                 @cell, @cell.colorize(background: :black), 
                 @cell, @cell.colorize(background: :black),
                 @cell, @cell.colorize(background: :black), 
                 @cell, @cell.colorize(background: :black) ]
    @b_row   = [ @space, 
                 @cell.colorize(background: :black), @cell, 
                 @cell.colorize(background: :black), @cell, 
                 @cell.colorize(background: :black), @cell, 
                 @cell.colorize(background: :black), @cell ]
    @letters = "\n    a     b     c     d     e     f     g     h     "
  end

  def fill_cells
    @board = @board.each_with_index.map do |i, y|
      i.each_with_index.map { |j, x| { input: "      ", x: x+1, y: y+1 } }
    end
  end

  def cell_color(cell)
    :black if ((cell[:y].even? && cell[:x].even?) || 
               (cell[:y].odd?  && cell[:x].odd?))
  end

  def color_letters(letters)
    colorize = letters.split('')
    colorize.map! do |char|
      if char =~ /[a-h]/
        char.colorize(:white)
      else
        char
      end
    end
    colorize.join
  end

  def reverse_board
    @board.reverse!
  end

  def print_board
    board.reverse!
    print color_letters(@letters)

    board.each_with_index do |row, row_index|
      row_number = row[row_index][:y].to_s.colorize(:white)

      puts ""
      puts row_index.even? ? @w_row.join : @b_row.join
      print row_number + " "
      
      row.each_with_index do |cell, cell_index|
        color = cell_color(cell)
        print cell[:input].colorize(background: color)
      end

      print " " + row_number
      print row_index.even? ? "\n#{@w_row.join}" : "\n#{@b_row.join}"
    end
    
    print color_letters(@letters) + "\n"
  end

  def set_piece_coordinates(name)
    x, y = (name[:coordinates][:x] - 1), (name[:coordinates][:y] - 1)
    x, y = y, x

    board[x][y][:input] = name[:symbol]
  end
end