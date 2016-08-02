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
    e8 to c8 castle
    b5 to c6 en passant
    d7 to d8 promotion
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