class SpecialMoves
	#en passant
	#castle
	#promotion
	attr_reader :advantage, :actions
	
	def initialize
		@advantage = Advantage.new
		@actions   = BasicActions.new
	end

	def castle(origin, destination, all_pieces)
		puts "castle"

		#puts all_pieces
	end

	def valid_castle?(origin, destination, all_pieces)
		# must be clear path
		# must be unmoved
		
		castle_path = [origin, destination]
		king_moves  = [
			[{x:5, y:1}, {x:7, y:1}],	#white short		king e1 g1 (rook h1 f1)
			[{x:5, y:1}, {x:3, y:1}],	#white long  		king e1 c1 (rook a1 d1)
			[{x:5, y:8}, {x:7, y:8}],	#black short		king e8 g8 (rook h8 f8)
			[{x:5, y:8}, {x:3, y:8}],	#black long			king e8 c8 (rook a8 d8)
		]

		castle_move = king_moves.select { |coord| coord == castle_path }
		castle_move = castle_move[0]
		p castle_move
		true
	end
end