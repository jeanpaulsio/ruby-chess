require_relative 'display_board'

class GamePlay
	attr_reader :title

	def initialize
		@title = <<-eos
  ╔═╗╦ ╦╔═╗╔═╗╔═╗
  ║  ╠═╣║╣ ╚═╗╚═╗
  ╚═╝╩ ╩╚═╝╚═╝╚═╝

eos
	end

	def start
		@game = DisplayBoard.new
		@game.set_defaults
		
		clear_screen
		show_title

		some_move
		show_cell_info

		show_updated_board
	end

	def show_title
		puts @title
	end

	def clear_screen
		system 'clear' or system 'cls'
	end

	def show_updated_board
		@game.print_board
	end




	# begin test methods
	def some_move
		@game.board.move_piece("e2", "e4")
	end

	def show_cell_info
		@game.board.display_info("h2")
	end
	# end test methods


end

game = GamePlay.new
game.start