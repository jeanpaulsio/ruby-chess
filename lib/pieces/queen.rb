require_relative 'basic_moves'

class Queen < BasicMoves
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♕ " : "♛ "
		@data = { name: "queen", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?(origin, destination)
		#positive_slope? || 
		#negative_slope? ||
		#vertical_slope? || 
		#horizontal_slope?
	end
end