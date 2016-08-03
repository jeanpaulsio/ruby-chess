require 'colorize'
require 'colorized_string'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8){ Array.new(8) { "" } }
  end

  def fill_cells
    @board = @board.each_with_index.map do |i, y|
      i.each_with_index.map { |j, x| { input: "  ", x: x+1, y: y+1 } }
    end
  end

  def cell_color(cell)
    :black if ((cell[:y].even? && cell[:x].even?) || 
               (cell[:y].odd?  && cell[:x].odd?))
  end 

  def reverse_board
    @board.reverse!
  end

  def print_board
    board.reverse!
    board.each_with_index do |row, row_index|
      puts ""
      print row[row_index][:y].to_s + " "
      
      row.each_with_index do |cell, cell_index|
        color = cell_color(cell)
        print cell[:input].colorize(:background => color)
      end

    end
    puts "\n  a b c d e f g h"
  end

  def set_piece_coordinates(name)
    x, y = (name[:coordinates][:x] - 1), (name[:coordinates][:y] - 1)
    x, y = y, x

    board[x][y][:input] = name[:symbol]
  end
end