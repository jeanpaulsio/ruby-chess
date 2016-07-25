require_relative 'board_actions'
require 'colorize'
require 'colorized_string'

class SetBoard
	attr_reader :board
	attr_accessor :game_board

	def initialize
		@pieces     = GamePieces.new
		@board      = BoardActions.new
		@nine       = board.generate_row(9)
		@eight      = board.generate_row(8)
		@seven      = board.generate_row(7)
		@six        = board.generate_row(6)
		@five       = board.generate_row(5)
		@four       = board.generate_row(4)
		@three      = board.generate_row(3)
		@two        = board.generate_row(2)
		@one        = board.generate_row(1)

		@game_board = [@nine, @eight, @seven, @six, @five, 
									 @four, @three, @two, @one]
	end

	def make_row(row)
		row.map! do |i|
			if i.data[:row] == 9
				i.data[:input] = "#{i.data[:col]} "
			else
			
				i.data[:input].colorize(background: i.data[:bg])
			end
		end
	end

	def set_pawns(color)
		97.upto(104) do |num|
			num = num.chr
			if color == :black
				num += "7"
			elsif color == :white
				num += "2"
			end
			board.place_piece(num, @pieces.pawn[color])
		end
	end

	def print_board
		game_board.each do |i|
			i.each{|j| @row_num = j.data[:row]}

			print @row_num == 9 ? "  " : "#{@row_num} "
			make_row(i)
			puts i.join
		end
	end
end