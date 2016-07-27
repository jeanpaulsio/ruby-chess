require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'

class GamePieces
	attr_accessor :black_symbols, :white_symbols, :all_symbols

	def initialize
		@black_rook1   = Rook.new(2, 7, "black")
		@black_rook2   = Rook.new(7, 7, "black")
		@white_rook1   = Rook.new(2, 2, "white")
		@white_rook2   = Rook.new(7, 2, "white")
		@all_symbols   = [@black_rook1, @black_rook2, @white_rook1, @white_rook2]
=begin
		@black_rook1   = Rook.new(1, 8, "black")
		@black_rook2   = Rook.new(8, 8, "black")
		@black_knight1 = Knight.new(2, 8, "black")
		@black_knight2 = Knight.new(7, 8, "black")
		@black_bishop1 = Bishop.new(3, 8, "black")
		@black_bishop2 = Bishop.new(6, 8, "black")
		@black_queen   = Queen.new(4, 8, "black")
		@black_king    = King.new(5, 8, "black")
		@black_pawn1   = Pawn.new(1, 7, "black")
		@black_pawn2   = Pawn.new(2, 7, "black")
		@black_pawn3   = Pawn.new(3, 7, "black")
		@black_pawn4   = Pawn.new(4, 7, "black")
		@black_pawn5   = Pawn.new(5, 7, "black")
		@black_pawn6   = Pawn.new(6, 7, "black")
		@black_pawn7   = Pawn.new(7, 7, "black")
		@black_pawn8   = Pawn.new(8, 7, "black")

		@white_rook1   = Rook.new(1, 1, "white")
		@white_rook2   = Rook.new(8, 1, "white")
		@white_knight1 = Knight.new(2, 1, "white")
		@white_knight2 = Knight.new(7, 1, "white")
		@white_bishop1 = Bishop.new(3, 1, "white")
		@white_bishop2 = Bishop.new(6, 1, "white")
		@white_queen   = Queen.new(4, 1, "white")
		@white_king    = King.new(5, 1, "white")
		@white_pawn1   = Pawn.new(1, 2, "white")
		@white_pawn2   = Pawn.new(2, 2, "white")
		@white_pawn3   = Pawn.new(3, 2, "white")
		@white_pawn4   = Pawn.new(4, 2, "white")
		@white_pawn5   = Pawn.new(5, 2, "white")
		@white_pawn6   = Pawn.new(6, 2, "white")
		@white_pawn7   = Pawn.new(7, 2, "white")
		@white_pawn8   = Pawn.new(8, 2, "white")
	
		@black_symbols = [@black_rook1, @black_rook2, @black_knight1, @black_knight2,
											@black_bishop1, @black_bishop2, @black_queen, @black_king,
											@black_pawn1, @black_pawn2, @black_pawn3, @black_pawn4,
											@black_pawn5, @black_pawn6, @black_pawn7, @black_pawn8]

		@white_symbols = [@white_rook1, @white_rook2, @white_knight1, @white_knight2,
											@white_bishop1, @white_bishop2, @white_queen, @white_king,
											@white_pawn1, @white_pawn2, @white_pawn3, @white_pawn4,
											@white_pawn5, @white_pawn6, @white_pawn7, @white_pawn8]

		@all_symbols   = @black_symbols + @white_symbols
=end
	end
end