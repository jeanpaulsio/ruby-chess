class Messages
	def turn(player)
    puts "\n» #{player.color.capitalize}'s turn:"
  end

	def capture(captured_piece, player)
    "\nYour #{captured_piece.data[:name].capitalize} was captured."
  end

  def friendly_fire
    "\nTraitor! No friendly fire, bud."
  end

  def protect_king(player)
    "\n#{player.color.capitalize}, protect your Lord Commander!"
  end

  def error
  	"\nYou know nothing, try again."
  end

  def check(threat)
    "\n#{threat.data[:color].capitalize} #{threat.data[:name].capitalize} "\
    "wants the Command Line Throne."\
    "\nMake move to escape Check."
  end

  def empty_origin
    "\nWhat is dead may never die. No piece there."
  end
end