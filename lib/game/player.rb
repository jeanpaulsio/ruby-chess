class Player
	attr_reader :color
	attr_accessor :total_moves

	def initialize(color)
		@color = color
		@total_moves = 0
	end

	def take_turn
		ans = gets.chomp
	end
end