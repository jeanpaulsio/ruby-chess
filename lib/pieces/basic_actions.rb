class BasicActions
  def move_piece(origin, destination, pieces)
    target = pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
    target[0].data[:coordinates] = destination
  end

  def delete_piece(coord, pieces)
    pieces.all_symbols.delete_if do |piece|
      piece.data[:coordinates] == coord
    end
  end

  def find_piece(origin, pieces)
    target = pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
    target[0]
  end

  def increase_move_count(piece, player)
    piece.data[:move_count] += 1
    player.total_moves += 1
  end

  def decrease_move_count(piece, player)
    piece.data[:move_count] -= 1
    player.total_moves -= 1
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

  def empty_spot?(spot, all_pieces)
    target = all_pieces.select { |piece| piece[:coordinates] == spot }
    target.empty? ? true : false
  end

  def capture_piece?(origin, destination, all_pieces)
    coord1 = all_pieces.select { |piece| piece[:coordinates] == origin }
    coord2 = all_pieces.select { |piece| piece[:coordinates] == destination }

    coord1[0][:color] != coord2[0][:color]
  end

  def friendly_fire?(origin, destination, all_pieces)
    coord1 = all_pieces.select { |piece| piece[:coordinates] == origin }
    coord2 = all_pieces.select { |piece| piece[:coordinates] == destination }

    coord1[0][:color] == coord2[0][:color]
  end
end