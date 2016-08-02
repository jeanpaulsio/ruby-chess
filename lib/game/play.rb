require_relative 'player'
require_relative 'board'
require_relative 'instructions'
require_relative 'game_pieces'

require './lib/pieces/basic_actions'

class Play
	attr_reader :actions

	def initialize
		@game         = Board.new
		@pieces       = GamePieces.new
		@player1      = Player.new("white")
		@player2      = Player.new("black")
		@actions      = BasicActions.new
		@instructions = Instructions.new

		play_game(@player1)
	end

	def play_game(player)
		display_board

		puts "\n» #{player.color.capitalize}'s turn:"
		ans = player.take_turn
		ans = ans.scan(/[a-h][1-8] to [a-h][1-8]|castle?|en passant?|promotion?/)

		if ans.empty?
			error_message
			play_game(player)
		elsif ans.include? "castle"
			puts "TODO: implement castle"
			make_move(ans, player)
			switch_players(player)
		
		elsif ans.include? "en passant"
			puts "TODO: implement en passant"
			make_move(ans, player)
			switch_players(player)
		
		elsif ans.include? "promotion"
			puts "TODO: implement promotion"
			make_move(ans, player)
			switch_players(player)
		
		else
			make_move(ans, player)
			switch_players(player)
		end
	end

	def make_move(user_input, player)
		user_input           = user_input[0].split("")
		x1, y1               = (user_input[0].ord  - 96), user_input[1].to_i
		x2, y2               = (user_input[-2].ord - 96), user_input[-1].to_i
		origin               = { x:x1, y:y1 }
		destination          = { x:x2, y:y2 }

		piece                = find_piece_at(origin)
		origin_is_empty      = actions.empty_spot?(origin, pieces_array)
		destination_is_empty = actions.empty_spot?(destination, pieces_array)

		error_message(player) if origin_is_empty

		if piece.valid_move?(origin, destination, pieces_array) && 
			 player.color == piece.data[:color]
			
			if destination_is_empty
				move_piece(origin, destination)
				piece.data[:move_count] += 1
				player.total_moves += 1
			elsif actions.friendly_fire?(origin, destination, pieces_array)
				friendly_fire_message(player)
			else
				captured_piece = find_piece_at(destination)
				capture_message(captured_piece)
				delete_piece_at(destination)
				
				move_piece(origin, destination)
				piece.data[:move_count] += 1
				player.total_moves += 1
			end
		
		else
			error_message(player)
		end

	end

	def display_board
		pause
		clear_screen
		fill_board
		show_instructions
		print_board
		reverse_board
	end

	def pieces_array
		ans = @pieces.all_symbols.map{|i|i.data}
		ans
	end

	def pause
		sleep 0.5
	end

	def clear_screen
		system 'clear' or system 'cls'
	end

	def fill_board
		@game.fill_cells
		@pieces.all_symbols.each { |piece| @game.set_piece_coordinates(piece.data) }
	end

	def show_instructions
		@instructions.display
	end

	def print_board
		@game.print_board
	end

	def reverse_board
		@game.reverse_board
	end

	def error_message(player)
		puts "Don't ever play yourself."
		play_game(player)
		pause
	end

	def friendly_fire_message(player)
		puts "No Friendly Fire!"
		error_message(player)
	end

	def capture_message(captured_piece)
		puts "#{captured_piece.data[:color].capitalize}'s #{captured_piece.data[:name]} has been captured!"
	end

	def switch_players(player)
		player = player == @player1 ? @player2 : @player1
		play_game(player)
	end

	def move_piece(origin, destination)
		target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
		target[0].data[:coordinates] = destination
	end

	def delete_piece_at(coord)
 		@pieces.all_symbols.delete_if do |piece|
 			piece.data[:coordinates] == coord
 		end
 	end

	def find_piece_at(origin)
		target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
		target[0]
	end
end

Play.new