require_relative 'board'
require_relative 'game_pieces'
require_relative 'player'
require './lib/pieces/rook'
require './lib/pieces/bishop'

class Play

	def initialize
		@game    = Board.new
		@pieces  = GamePieces.new
		@player1 = Player.new("white")
		@player2 = Player.new("black")
		
		clear_screen
		fill_board
		play_game(@player1)

	end

	def play_game(player)
		clear_screen
		print_board
		reverse_board

		puts "» #{player.color.capitalize}'s turn:"
		ans = player.take_turn
		ans = ans.scan(/[a-h][1-8] to [a-h][1-8]/)

		if ans.empty?
			error_message
			pause
			play_game(player)
		else
			ans = ans[0].split("")

			x1 = ans[0].ord  - 96
			x2 = ans[-2].ord - 96
			y1 = ans[1]
			y2 = ans[-1]

			puts "#{x1}, #{y1}"
			puts "#{x2}, #{y2}"
		end


		pause
		
		switch_players(player)
	end

	def pieces_array
		ans = @pieces.all_symbols.map{|i|i.data}
		ans
	end

	def fill_board
		@game.fill_cells
		@pieces.all_symbols.each { |piece| @game.set_piece_coordinates(piece.data) }
	end

	def print_board
		@game.print_board
	end

	def reverse_board
		@game.reverse_board
	end

	def pause
		sleep 0.5
	end

	def error_message
		puts "Nice try, big guy"
	end

	def switch_players(player)
		player = player == @player1 ? @player2 : @player1
		play_game(player)
	end

	def clear_screen
		system 'clear' or system 'cls'
	end











	def identify_piece_symbol(origin)
		target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
		#check_moves(target[0])
		puts target[0].data[:name]
	end



	def check_moves(symbol)

		puts symbol.clear_vertical_path?({x:2,y:7},{x:7,y:7}, pieces_array)
		puts symbol.clear_horizontal_path?({x:3,y:7},{x:6,y:7}, pieces_array)
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
		pieces_array.each do |i|
			puts i[:name]
		end
	end
end




game = Play.new