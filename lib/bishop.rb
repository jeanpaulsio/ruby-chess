class Bishop
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♗ " : "♝ "
		@data = { name: "bishop", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?
		positive_slope? || negative_slope?
	end

	def positive_slope?(origin, destination)
		y2, y1 = destination[:y], origin[:y]
		x2, x1 = destination[:x], origin[:x]

		(y2 - y1)/(x2 - x1) ==  1
	end

	def negative_slope?(origin, destination)
		y2, y1 = destination[:y], origin[:y]
		x2, x1 = destination[:x], origin[:x]

		(y2 - y1)/(x2 - x1) == -1
	end

	def bounding_box(origin, destination, all_pieces)
		x1 = origin[:x] < destination[:x] ? origin[:x] : destination[:x]
		x2 = origin[:x] < destination[:x] ? destination[:x] : origin[:x]
		y1 = origin[:y] < destination[:y] ? origin[:y] : destination[:y]
		y2 = origin[:y] < destination[:y] ? destination[:y] : origin[:y]

		bounded_values = all_pieces.select do |piece|
			piece[:coordinates][:x].between?(x1, x2) &&
			piece[:coordinates][:y].between?(y1, y2)
		end
	end

	def clear_positive_slope?(origin, bounded_values)
		x1, y1 = origin[:x].to_f, origin[:y].to_f

		bounded_values.none? do |i| 
			((i[:coordinates][:y] - y1)/(i[:coordinates][:x] - x1)) == 1
		end
	end

	def clear_negative_slope?(origin, bounded_values)
		x1, y1 = origin[:x].to_f, origin[:y].to_f
		
		bounded_values.none? do |i| 
			((i[:coordinates][:y] - y1)/(i[:coordinates][:x] - x1)) == -1
		end
	end

end