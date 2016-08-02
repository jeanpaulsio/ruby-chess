require_relative 'board'
require_relative 'game_pieces'
require_relative 'player'
require './lib/pieces/basic_actions'

class Play
	attr_reader :actions

	def initialize
		@game    = Board.new
		@pieces  = GamePieces.new
		@player1 = Player.new("white")
		@player2 = Player.new("black")
		@actions = BasicActions.new
		@title = <<-eos
╔═╗╦ ╦╔═╗╔═╗╔═╗
║  ╠═╣║╣ ╚═╗╚═╗
╚═╝╩ ╩╚═╝╚═╝╚═╝
		eos
		@instructions = <<-eos
» Welcome to Ruby Chess
» Player 1 is White
» Player 2 is Black
» Players move their piece like this:
    a2 to a4
		eos

		play_game(@player1)
	end

	def play_game(player)
		display_board

		puts "\n» #{player.color.capitalize}'s turn:"
		ans = player.take_turn
		ans = ans.scan(/[a-h][1-8] to [a-h][1-8]/)

		if ans.empty?
			error_message
			play_game(player)
		else
			make_move(ans, player)
		end
		
		switch_players(player)
	end

	def make_move(user_input, player)
		user_input       = user_input[0].split("")
		x1, y1           = (user_input[0].ord  - 96), user_input[1].to_i
		x2, y2           = (user_input[-2].ord - 96), user_input[-1].to_i
		origin           = { x:x1, y:y1 }
		destination      = { x:x2, y:y2 }

		piece            = find_piece_at({ x:x1, y:y1 })
		spot_is_empty    = actions.empty_spot?({ x:x2, y:y2 }, pieces_array)
		origin_is_empty  = actions.empty_spot?({ x:x1, y:y1 }, pieces_array)

		# error if player calls on empty square
		if origin_is_empty
			error_message(player)
			
		# checks validation if player moves their own piece
		elsif piece.valid_move?(origin, destination, pieces_array) && (player.color == piece.data[:color])
			
			if spot_is_empty
				move_piece(origin, destination)
				
				piece.data[:move_count] += 1
				player.total_moves += 1
			else
				if actions.friendly_fire?(origin, destination, pieces_array)
					error_message(player)
				else
					captured_piece = find_piece_at(destination)
					capture_message(captured_piece)

					delete_piece_at(destination)
					move_piece(origin, destination)
					
					piece.data[:move_count] += 1
					player.total_moves += 1
				end
			end

		# returns error if piece's move is not valid
		else
			error_message(player)
		end
	end

	def en_passant?(origin)
		target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
		target[0].data[:enpassant] = (target[0].data[:move_count] == 1) ? true : false

		return target[0].data[:enpassant]
	end

	def display_board
		pause
		clear_screen
		fill_board
		puts @title
		puts @instructions
		print_board
		reverse_board
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

	def pause
		sleep 0.5
	end

	def error_message(player)
		puts "Nice try, big guy"
		play_game(player)
		pause
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

game = Play.new