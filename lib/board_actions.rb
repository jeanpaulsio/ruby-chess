require_relative 'cell'
require_relative 'game_pieces'

class BoardActions
	attr_reader :game_pieces, :empty_cell

	def initialize
		@empty_cell  = "  "
	end

	def find_cell_color(col, row)
		:black if col.even? && row.even? || col.odd? && row.odd?
	end

	def generate_row(num)
		arr = []
		97.upto(104) do |i|
			color    = find_cell_color(i, num) 
			letter   = i.chr
			var_name = "@" + letter + num.to_s
			instance_variable_set(var_name, (Cell.new(color, letter, num)))
			
			arr << instance_variable_get(var_name)
		end
		arr
	end

	def place_piece(spot_on_board, piece)
		spot_on_board = "@" + spot_on_board
		instance_variable_get(spot_on_board).data[:input] = piece
	end

	def move_piece(from, to)
		from = "@" + from
		to   = "@" + to

		instance_variable_get(to).data[:input]   = instance_variable_get(from).data[:input]
		instance_variable_get(from).data[:input] = empty_cell
	end
end