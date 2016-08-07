class King
  attr_reader :data
  
  def initialize(x, y, color)
    symbol = color == "white" ? "  ♔   " : "  ♚   "
    @data = { name: "king", color: color, symbol: symbol, 
              coordinates: {x: x, y: y}, move_count: 0, 
              check: false }
  end

  def valid_move?(origin, destination, all_pieces=[])
    x, y   = origin[:x], origin[:y]
    status = false
    possible_king_moves = [
      {x:x-1, y:y-1}, {x:x, y:y-1}, {x:x+1, y:y-1},
      {x:x-1, y:y  }, {x:x+1, y:y},
      {x:x-1, y:y+1}, {x:x, y:y+1}, {x:x+1, y:y+1}
    ]

    status = true if possible_king_moves.include? destination

    return status
  end
end