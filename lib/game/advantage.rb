class Advantage
  def check?(player_pieces, destination, all_pieces)
    status = false
    player_pieces.each do |piece|
      origin = piece.data[:coordinates]
      if piece.valid_move?(origin, destination, all_pieces)
        piece.data[:check] = true
        puts "Check by: #{piece.data[:name].upcase}"
        status = true
      else
        piece.data[:check] = false
      end

      p piece if piece.data[:check]
    end
    status
  end

  def checkmate?(player_pieces, destination, all_pieces)
    status = false
    status
  end

  def stalemate?
  end
end