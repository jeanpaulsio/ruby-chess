class Piece
	def empty_spot?(destination, all_pieces)
		target = all_pieces.select { |piece| piece[:coordinates] == destination }
		target.empty? ? true : false
	end

	def invalid_move?
		true
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