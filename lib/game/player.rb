class Player
	attr_reader :color
	attr_accessor :moves

	def initialize(color)
		@color = color
		@moves = []
	end

	def take_turn
		ans = gets.chomp
	end
end