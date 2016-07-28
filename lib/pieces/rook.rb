require_relative 'basic_moves'

class Rook < BasicMoves 
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♖ " : "♜ "
		@data = { name: "rook", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?
		#vertical_slope? || horizontal_slope?
	end
end