class GamePieces
	attr_reader :rook, :knight, :bishop, :queen, :king, :pawn

	def initialize
		@rook   = {name: "rook",   black: "♜ ", white: "♖ "}
		@knight = {name: "knight", black: "♞ ", white: "♘ "}
		@bishop = {name: "bishop", black: "♝ ", white: "♗ "}
		@queen  = {name: "queen",  black: "♛ ", white: "♕ "}
		@king   = {name: "king",   black: "♚ ", white: "♔ "}
		@pawn   = {name: "pawn",   black: "♟ ", white: "♙ "}
	end
end