require_relative '_board'
require_relative '_game_pieces'

system 'clear' or system 'cls'

class Play
	def initialize
		@game   = Board.new
		@pieces = GamePieces.new


		
		#delete_piece_at( {x:5, y:2} )
		do_some_stuff( {x:2, y:1}, {x:2, y:5} )
		show_all_pieces
		fill_board
		print_board
	end

	def fill_board
		@game.fill_cells
		
		@pieces.all_symbols.each do |piece| 
			@game.set_piece_coordinates(piece.data)
		end
	end

	def print_board
		@game.print_board
	end




	def do_some_stuff(origin, destination)
		a = @pieces.all_symbols.select do |pieces| 
			pieces.data[:coordinates] == origin			#origin coordinates
		end

		a[0].data[:coordinates] = destination     #destination coordinates

	end

	def delete_piece_at(coord)
		@pieces.all_symbols.delete_if do |piece|
			piece.data[:coordinates] == coord
		end
	end

	def show_all_pieces
		# shows pieces
		@pieces.all_symbols.each do |i|
			puts i.data[:color]
		end
	end
end

Play.new