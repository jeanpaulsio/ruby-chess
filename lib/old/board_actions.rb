require_relative 'cell'
require_relative 'game_pieces'

class BoardActions
	attr_reader :game_pieces, :empty_cell

	def initialize
		@empty_cell  = "  "
	end

	# method colors dark cell
	def find_cell_color(col, row)
		:black if col.even? && row.even? || col.odd? && row.odd?
	end

	# method generates instance variables a1 - h8
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

	def place_piece(destination, piece)
		color = (destination =~ /[7-8]/) ? :black : :white
		
		destination = "@" + destination
		cell = instance_variable_get(destination)

		cell.data[:player_color] = color.to_s
		cell.data[:piece]        = piece[:name]
		cell.data[:input]        = piece[color]
	end

	def move_piece(from, to)
		from = "@" + from
		to   = "@" + to

		origin      = instance_variable_get(to)
		destination = instance_variable_get(from)
		
		origin.data[:player_color] = destination.data[:player_color]
		origin.data[:piece]        = destination.data[:piece]
		origin.data[:input]        = destination.data[:input]
		
		destination.data[:input], 
		destination.data[:piece],
		destination.data[:player_color] = empty_cell
	end

	def display_info(spot_on_board)
		spot_on_board = "@" + spot_on_board
		puts "Info for cell: #{spot_on_board}"
		puts instance_variable_get(spot_on_board)
	end
end