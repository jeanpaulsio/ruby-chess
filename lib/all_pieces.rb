class AllPieces
	def empty_spot?(destination, all_pieces)
		target = all_pieces.select { |piece| piece[:coordinates] == destination }
		target.empty? ? true : false
	end

	def invalid_move?
		true
	end
end