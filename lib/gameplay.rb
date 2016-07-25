require_relative 'display_board'
system 'clear' or system 'cls'

class GamePlay
	attr_reader :title

	def initialize
		@title = <<-eos
  ╔═╗╦ ╦╔═╗╔═╗╔═╗
  ║  ╠═╣║╣ ╚═╗╚═╗
  ╚═╝╩ ╩╚═╝╚═╝╚═╝

eos
		
		puts @title
	end

	def start
		@game = DisplayBoard.new
		@game.set_defaults
		
		fake_move
		show_cell_info
		show_updated_board
	end

	def fake_move
		@game.board.move_piece("d2", "d3")
		#puts @game.board
	end

	def show_cell_info
		@game.board.display_info("h8")
	end

	def show_updated_board
		@game.print_board
	end
end

game = GamePlay.new
game.start