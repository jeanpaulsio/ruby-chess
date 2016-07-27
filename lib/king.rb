class King
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♔ " : "♚ "
		@data = { name: "king", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?(origin, destination)
		false
	end
end