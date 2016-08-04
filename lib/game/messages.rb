class Messages
	def turn(player)
    puts "\n» #{player.color.capitalize}'s turn:"
  end

	def capture(captured_piece)
    puts "#{captured_piece.data[:color].capitalize}'s "\
         "#{captured_piece.data[:name]} has been captured!"
  end

  def friendly_fire(player)
    puts "No Friendly Fire!"
  end

  def protect_king(player)
    puts "#{player.color.capitalize}, protect your King!"
  end

  def error(player)
  	puts "You played yourself."
  end

  def check(player)
    puts player.color == "white" ? "(Black in Check)" : "(White in Check)"
  end
end