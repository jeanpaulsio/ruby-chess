class Advantage
	def check?(player, white_pieces, black_pieces)
		king_piece = find_king(player, white_pieces, black_pieces)
		puts king_piece[:coordinates]
	end

	def find_king(player, white_pieces, black_pieces)
		if player.color == "white"
			king_piece = black_pieces.select{ |piece| piece[:name] == "king" }
			return king_piece[0]
		else
			king_piece = white_pieces.select{ |piece| piece[:name] == "king" }
			return king_piece[0]
		end
	end

	def checkmate?
	end

	def stalemate?
	end
end