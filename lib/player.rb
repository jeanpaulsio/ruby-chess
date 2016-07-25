class Player
	attr_reader :color

	def initialize(color)
		@color = color
	end

	def take_turn
		puts "» Type your move:"
		ans = gets
	end
end