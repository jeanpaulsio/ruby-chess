require_relative 'set_board'
require_relative 'board_actions'
system 'clear' or system 'cls'

@title = <<-eos
  ╔═╗╦ ╦╔═╗╔═╗╔═╗
  ║  ╠═╣║╣ ╚═╗╚═╗
  ╚═╝╩ ╩╚═╝╚═╝╚═╝

eos

puts @title

a = SetBoard.new
a.set_pawns(:black)
a.set_pawns(:white)
a.board.move_piece("d2", "d4")
a.print_board