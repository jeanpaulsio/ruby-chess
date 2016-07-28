require_relative 'basic_moves'

class Bishop < BasicMoves
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♗ " : "♝ "
		@data = { name: "bishop", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?
		#positive_slope? || negative_slope?
	end
end