class Instructions
	attr_reader :title, :instructions

	def initialize
		@title = <<-eos
╔═╗╦ ╦╔═╗╔═╗╔═╗
║  ╠═╣║╣ ╚═╗╚═╗
╚═╝╩ ╩╚═╝╚═╝╚═╝
		eos
		@instructions = <<-eos
» Welcome to Ruby Chess
» Regular move examples: 
    a2 to a4
    d7 to d5
» Special move examples: 
    castle e8 to c8
    caslte e8 to g8
    castle e1 to g1
    castle e1 to c1
» Need to implement:
    - en passant
    - castling
    - check/mate/stalemate
		eos
	end

	def display
		puts @title
		puts @instructions
	end
end