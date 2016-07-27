class Bishop
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♗ " : "♝ "
		@data = { name: "bishop", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?(origin, destination)
		y2, y1 = destination[:y], origin[:y]
		x2, x1 = destination[:x], origin[:x]

		(y2 - y1)/(x2 - x1) ==  1 || 
		(y2 - y1)/(x2 - x1) == -1
	end
end