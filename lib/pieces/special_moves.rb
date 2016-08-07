class SpecialMoves
	#en passant
	#castle
	#promotion

	def en_passant_status(piece, origin, destination, player)
		en_passant_move_count = player.total_moves

		status = 
			(origin[:y] - destination[:y]).abs == 2 &&
			piece.data[:name] == "pawn"

		piece.data[:enpassant] = status
	end
end