class BasicActions
  def move_piece(origin, destination, all_pieces)
    target = all_pieces.select { |piece| piece[:coordinates] == origin}
    target[0][:coordinates] = destination
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

  def find_king(player, all_pieces)
    king_piece = all_pieces.select{ |i| i[:color] == player.color && i[:name] == "king" }
    king_piece[0][:coordinates]
  end

  def empty_spot?(spot, all_pieces)
    target = all_pieces.select { |piece| piece[:coordinates] == spot }
    target.empty? ? true : false
  end

end