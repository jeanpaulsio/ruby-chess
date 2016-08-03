class Advantage
  def check?(player, white_pieces, black_pieces)
    all_pieces      = white_pieces + black_pieces
    king_piece      = find_king(player, white_pieces, black_pieces)
    destination     = king_piece[:coordinates]
    player_is_white = player.color == "white"
    
    player_is_white ? check_if_check(white_pieces, destination) : check_if_check(black_pieces, destination)
  end

  def find_king(player, white_pieces, black_pieces)
    if player.color == "white"
      king_piece = black_pieces.select{ |piece| piece[:name] == "king" }
      return king_piece[0]
    else
      king_piece = white_pieces.select{ |piece| piece[:name] == "king" }
      return king_piece[0]
    end
  end

  def check_if_check(user_pieces, destination)
    user_pieces.each do |piece|
      puts piece
    end
  end

  def checkmate?
  end

  def stalemate?
  end
end