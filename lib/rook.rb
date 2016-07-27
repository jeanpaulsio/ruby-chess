class Rook
	attr_reader :data
	
	def initialize(x, y, color)
		symbol = color == "white" ? "♖ " : "♜ "
		@data = { name: "rook", color: color, symbol: symbol, coordinates: {x: x, y: y} }
	end

	def valid_move?(origin, destination)
		origin[:x] == destination[:x] ||
		origin[:y] == destination[:y]
	end

	def invalid_move?
		true
	end

	def vertical_slope?(origin, destination)
		origin[:x] == destination[:x]
	end

	def horizontal_slope?(origin, destination)
		origin[:y] == destination[:y]
	end

	def clear_vertical_path?(origin, destination, all_pieces)
		x1, x2 = origin[:x], destination[:x]
		y1, y2 = origin[:y], destination[:y]

		x_values = all_pieces.select { |piece| piece[:coordinates][:x] == x1 }
		!x_values.any? { |piece| (y1...y2).include? piece[:coordinates][:y] }
	end

	def clear_horizontal_path?(origin, destination, all_pieces)
		x1, x2 = origin[:x], destination[:x]
		y1, y2 = origin[:y], destination[:y]

		y_values = all_pieces.select { |piece| piece[:coordinates][:y] == y1 }
		!y_values.any? { |piece| (x1...x2).include? piece[:coordinates][:x] }
	end

	def capture_piece?(origin, destination, all_pieces)
		coord1 = all_pieces.select { |piece| piece[:coordinates] == origin }
		coord2 = all_pieces.select { |piece| piece[:coordinates] == destination }

		coord1[0][:color] != coord2[0][:color]
	end

	def friendly_fire?(origin, destination, all_pieces)
		coord1 = all_pieces.select { |piece| piece[:coordinates] == origin }
		coord2 = all_pieces.select { |piece| piece[:coordinates] == destination }

		coord1[0][:color] == coord2[0][:color]
	end
end