require_relative '_board'
require_relative '_game_pieces'
require_relative 'rook'
require_relative 'bishop'

system 'clear' or system 'cls'

class Play

	def initialize
		@game   = Board.new
		@pieces = GamePieces.new
		
		#delete_piece_at( {x:2, y:7} )
		#move_piece( {x:2, y:2}, {x:2, y:1} )
		
		#show_all_pieces
		fill_board
		print_board

		find_piece_symbol( {x:7, y:2} )
	end

	def pieces_array
		ans = @pieces.all_symbols.map{|i|i.data}
		ans
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

	def find_piece_symbol(origin)
		target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
		check_moves(target[0])
	end



	def check_moves(symbol)
		#puts symbol.valid_move?({x:4,y:1},{x:4,y:5})
		#puts symbol.vertical_slope?({x:8,y:1},{x:8,y:7})

		puts symbol.clear_vertical_path?({x:2,y:7},{x:7,y:7}, pieces_array)
		puts symbol.clear_horizontal_path?({x:3,y:7},{x:6,y:7}, pieces_array)
		#puts symbol.capture_piece?({x:2,y:7},{x:7,y:7}, pieces_array)
		#puts symbol.capture_piece?({x:2,y:7},{x:2,y:1}, pieces_array)
	  #puts symbol.friendly_fire?({x:2,y:7},{x:7,y:7}, pieces_array)
		#puts symbol.friendly_fire?({x:2,y:7},{x:2,y:1}, pieces_array)
	end


	def move_piece(origin, destination)
		a = pieces_array.select do |pieces| 
			pieces[:coordinates] == origin			#origin coordinates
		end

		a[0][:coordinates] = destination     #destination coordinates
	end

	def delete_piece_at(coord)
		@pieces.all_symbols.delete_if do |piece|
			piece.data[:coordinates] == coord
		end
	end

	def show_all_pieces
		# shows pieces
		pieces_array.each do |i|
			puts i[:name]
		end
	end
end

Play.new