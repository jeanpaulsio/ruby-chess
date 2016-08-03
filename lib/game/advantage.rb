class Advantage
  def check?(player, white_pieces, black_pieces, all_pieces)
    king_piece      = find_king(player, white_pieces, black_pieces)
    destination     = king_piece[:coordinates]
    player_is_white = player.color == "white"
    player_is_black = player.color == "black"
    
    if player_is_white
      puts check_if_check(white_pieces, destination, all_pieces)
    elsif player_is_black
      puts check_if_check(black_pieces, destination, all_pieces)
    end
  end

  def find_king(player, white_pieces, black_pieces)
    if player.color == "white"
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

  def checkmate?
  end

  def stalemate?
  end
end