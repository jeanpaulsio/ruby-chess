class Advantage
  def check?(player, white_pieces, black_pieces, all_pieces)
    opponent_king          = find_opponent_king(player, white_pieces, black_pieces)
    opponent_king_location = opponent_king[:coordinates]

    user_king              = find_your_king(player, white_pieces, black_pieces)
    user_king_location     = user_king[:coordinates]
    
    player_is_white = player.color == "white"
    player_is_black = player.color == "black"
    
    if player_is_white
      check_if_check(white_pieces, opponent_king_location, all_pieces)
      puts "white in check" if protect_your_king(black_pieces, user_king_location, all_pieces)
    
    elsif player_is_black
      check_if_check(black_pieces, opponent_king_location, all_pieces)
      puts "black in check" if protect_your_king(white_pieces, user_king_location, all_pieces)

    end
  end

  def find_opponent_king(player, white_pieces, black_pieces)
    if player.color == "white"
      king_piece = black_pieces.select{ |piece| piece.data[:name] == "king" }
      return king_piece[0].data
    else
      king_piece = white_pieces.select{ |piece| piece.data[:name] == "king" }
      return king_piece[0].data
    end
  end

  def find_your_king(player, white_pieces, black_pieces)
    if player.color == "black"
      king_piece = black_pieces.select{ |piece| piece.data[:name] == "king" }
      return king_piece[0].data
    else
      king_piece = white_pieces.select{ |piece| piece.data[:name] == "king" }
      return king_piece[0].data
    end
  end

  def check_if_check(user_pieces, destination, all_pieces)
    status = false
    user_pieces.each do |piece|
      origin = piece.data[:coordinates]
      status = true if piece.valid_move?(origin, destination, all_pieces)
    end
    status
  end

  def protect_your_king(opponent_pieces, destination, all_pieces)
    status = false
      opponent_pieces.each do |piece|
        origin = piece.data[:coordinates]
        status = true if piece.valid_move?(origin, destination, all_pieces)
      end
    status
  end

  def checkmate?
  end

  def stalemate?
  end
end