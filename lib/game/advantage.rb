class Advantage
  def check?(player_pieces, destination, all_pieces)
    status = false
    player_pieces.each do |piece|
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