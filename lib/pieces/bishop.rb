require_relative 'basic_moves'

class Bishop < BasicMoves
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♗ " : "♝ "
		@data = { name: "bishop", color: color, symbol: symbol, coordinates: {x: x, y: y}, move_count: 0 }
	end

	def valid_move?(origin, destination, all_pieces)
		bounded = bounding_box(origin, destination, all_pieces)

		( positive_slope?(origin, destination) && 
			clear_positive_slope?(origin, bounded) ) ||
		( negative_slope?(origin, destination) && 
			clear_negative_slope?(origin, bounded) ) 
	end
end