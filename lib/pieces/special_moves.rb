class SpecialMoves
	#en passant
	#promotion
	attr_reader :advantage, :actions
	
	def initialize
		@advantage  = Advantage.new
		@actions    = BasicActions.new

		@king_moves = {
			a: [{x:5, y:1}, {x:7, y:1}],	#king e1 g1 (rook h1 f1)
			b: [{x:5, y:8}, {x:7, y:8}],	#king e8 g8 (rook h8 f8)
			c: [{x:5, y:1}, {x:3, y:1}],	#king e1 c1 (rook a1 d1)
			d: [{x:5, y:8}, {x:3, y:8}],	#king e8 c8 (rook a8 d8)
		}

		@rook_moves = {
			a: [{x:8, y:1}, {x:6, y:1}],	#king e1 g1 (rook h1 f1)
			b: [{x:8, y:8}, {x:6, y:8}],	#king e8 g8 (rook h8 f8)
			c: [{x:1, y:1}, {x:4, y:1}],	#king e1 c1 (rook a1 d1)
			d: [{x:1, y:8}, {x:4, y:8}],	#king e8 c8 (rook a8 d8)
		}
	end

	def promote_pawn?(origin, destination, all_pieces)
		
	end


	def valid_castle?(origin, destination, opponent_pieces, all_pieces)
		castle_path = [origin, destination]
		king_path   = @king_moves.select { |i, move| move == castle_path }
		return false if king_path.empty?
		
		rook_path   = @rook_moves.select { |i, move| i == king_path.keys[0]  }

		king_origin, king_destination = king_path.values[0][0], king_path.values[0][1]
		rook_origin, rook_destination = rook_path.values[0][0], rook_path.values[0][1]

		king_piece  = all_pieces.select { |piece| piece[:coordinates] == king_origin }
		rook_piece  = all_pieces.select { |piece| piece[:coordinates] == rook_origin }
		move_count  = (king_piece[0][:move_count] == 0) && (rook_piece[0][:move_count] == 0)
		
		return false if !move_count
		return false if advantage.check?(opponent_pieces, king_destination, all_pieces)

		if king_path.keys[0] == :a || king_path.keys[0] == :b
			return false unless actions.empty_spot?({x:6, y:king_origin[:y]}, all_pieces) &&
													actions.empty_spot?({x:7, y:king_origin[:y]}, all_pieces)
		else
			return false unless actions.empty_spot?({x:2, y:king_origin[:y]}, all_pieces) &&
													actions.empty_spot?({x:3, y:king_origin[:y]}, all_pieces) &&
													actions.empty_spot?({x:4, y:king_origin[:y]}, all_pieces)
		end
		
		actions.move_piece(king_origin, king_destination, all_pieces)
		actions.move_piece(rook_origin, rook_destination, all_pieces)
	end
end