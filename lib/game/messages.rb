class Messages
  def blank
    ""
  end

	def turn(player)
    "\n» #{player.color.capitalize}'s turn:"
  end

	def capture(captured_piece, player)
    "\nYour #{captured_piece.data[:name].capitalize} was captured.\n"
  end

  def protect_king(player)
    "\n#{player.color.capitalize}, protect your Lord Commander!"
  end

  def check(threat)
    "\nThe #{threat.data[:color].capitalize} #{threat.data[:name].capitalize} "\
    "wants the Command Line Throne."\
    "\nMake move to escape Check."
  end

  def error
    "\nYou know nothing, try again.\n"
  end

  def invalid_input
    "\nFilthy Crow! Try this format: `d2 d3`"
  end

  def empty_origin
    "\nWhat is dead may never die. No piece there."
  end

  def game_over
    "\nThe mad King has been defeated."\
    "\nCheckmate!"
  end
end