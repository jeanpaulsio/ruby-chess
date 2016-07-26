class Queen
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♕ " : "♛ "
		@data = { name: "queen", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?(origin, destination)
		false
	end
end