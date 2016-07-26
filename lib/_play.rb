require_relative '_board'
require_relative '_game_pieces'

system 'clear' or system 'cls'

class Play
	def initialize
		@game   = Board.new
		@pieces = GamePieces.new

		do_some_stuff({x:2, y:1}, {x:3, y:3})
		fill_board
	end

	def fill_board
		@game.fill_cells
		
		@pieces.white_symbols.each do |i| 
			@game.set_default(i.data[:coordinates], i)
		end
		@pieces.black_symbols.each do |i| 
			@game.set_default(i.data[:coordinates], i)
		end

		print_board
	end

	def print_board
		@game.print_board
	end

	def do_some_stuff(origin, destination)
		a = @pieces.white_symbols.select do |pieces| 
			pieces.data[:coordinates] == origin			#origin coordinates
		end

		a[0].data[:coordinates] = destination  #destination coordinates

	end
end

Play.new