require 'colorize'
require 'colorized_string'

require_relative 'row'
system 'clear' or system 'cls'

@title = <<-eos
  ╔═╗╦ ╦╔═╗╔═╗╔═╗
  ║  ╠═╣║╣ ╚═╗╚═╗
  ╚═╝╩ ╩╚═╝╚═╝╚═╝
eos

board = Row.new

nine  = board.make_row(9)
eight = board.make_row(8)
seven = board.make_row(7)
six   = board.make_row(6)
five  = board.make_row(5)
four  = board.make_row(4)
three = board.make_row(3)
two   = board.make_row(2)
one   = board.make_row(1)

@game_board = [nine, eight, seven, six, five, four, three, two, one]

def print_row(row)
	row.map! do |i|
		if i.data[:row] == 9
			i.data[:input] = "#{i.data[:col]} "
		else
			i.data[:input] = "♞ " if ((i.data[:col] == "b") && (i.data[:row] == 8))
			i.data[:input].colorize(color: i.data[:text], background: i.data[:bg])
		end
	end
end

def print_board
	@game_board.each do |i|
		i.each{|j| @row_num = j.data[:row]}

		print @row_num == 9 ? "  " : "#{@row_num} "
		print_row(i)
		puts i.join
	end
end

def place_piece(piece)

end

puts @title
print_board


puts
board.stuff("b8")