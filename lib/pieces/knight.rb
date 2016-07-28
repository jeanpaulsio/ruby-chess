class Knight
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♘ " : "♞ "
		@data = { name: "knight", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?(origin, destination)
		false
	end
end