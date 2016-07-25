require_relative 'board_actions'
require 'colorize'
require 'colorized_string'

class DisplayBoard
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

		@pawn_defaults   = ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7",
												"a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"]
		@rook_defaults   = ["a8", "h8", "a1", "h1"]
		@knight_defaults = ["b8", "g8", "b1", "g1"]
		@bishop_defaults = ["c8", "f8", "c1", "f1"]
		@queen_defaults  = ["d8", "d1"]
		@king_defaults   = ["e8", "e1"]
	end

	def set_defaults
		@pawn_defaults.each   { |i| board.place_piece(i, @pieces.pawn) }
		@rook_defaults.each   { |i| board.place_piece(i, @pieces.rook) }
		@knight_defaults.each { |i| board.place_piece(i, @pieces.knight) }
		@bishop_defaults.each { |i| board.place_piece(i, @pieces.bishop) }
		@queen_defaults.each  { |i| board.place_piece(i, @pieces.queen) }
		@king_defaults.each   { |i| board.place_piece(i, @pieces.king) }
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

	def print_board
		game_board.each do |i|
			i.each{|j| @row_num = j.data[:row]}

			print @row_num == 9 ? "  " : "#{@row_num} "
			make_row(i)
			puts i.join
		end
	end
end