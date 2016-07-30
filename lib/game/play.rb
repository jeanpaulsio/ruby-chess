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
		
		play_game(@player1)
	end

	def play_game(player)
		display_board

		puts "» #{player.color.capitalize}'s turn:"
		ans = player.take_turn
		ans = ans.scan(/[a-h][1-8] to [a-h][1-8]/)

		if ans.empty?
			error_message
			play_game(player)
		else
			ans = ans[0].split("")
			x1, y1 = (ans[0].ord  - 96), ans[1].to_i
			x2, y2 = (ans[-2].ord - 96), ans[-1].to_i
		end
		
		move_piece({ x:x1, y:y1 }, { x:x2, y:y2 })
		switch_players(player)
	end

	def pieces_array
		ans = @pieces.all_symbols.map{|i|i.data}
		ans
	end

	def clear_screen
		system 'clear' or system 'cls'
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

	def display_board
		clear_screen
		fill_board
		print_board
		reverse_board
	end

	def pause
		sleep 0.5
	end

	def error_message
		puts "Nice try, big guy"
		pause
	end

	def switch_players(player)
		player = player == @player1 ? @player2 : @player1
		play_game(player)
	end


	### test shit

	def move_piece(origin, destination)
		target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
		target[0].data[:coordinates] = destination
	end

end

game = Play.new