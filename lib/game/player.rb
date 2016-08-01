class Player
	attr_reader :color

	def initialize(color)
		@color = color
	end

	def take_turn
		ans = gets.chomp
	end
end