require 'colorize'
require 'colorized_string'

class Board
	attr_accessor :board

	def initialize
		@board = Array.new(8){ Array.new(8) { "" } }
	end

	def fill_cells
		@board = @board.each_with_index.map do |i, y|
			i.each_with_index.map do |j, x| 
				{ designation: (y + 1).to_s + "#{(x + 97).chr}",
		      occupied:    false,
				  input:       "  ",
				  x:           x+1,
				  y:           y+1
				} 
			end
		end
	end

	def cell_color(cell)
		:black if ((cell[:y].even? && cell[:x].even?) || 
			         (cell[:y].odd?  && cell[:x].odd?))
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

	def set_default(coord, name)
		x = coord[:x] - 1
		y = coord[:y] - 1
		x, y = y, x

		board[x][y][:input] = name.data[:symbol]
	end

end