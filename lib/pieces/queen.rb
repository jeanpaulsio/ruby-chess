require_relative 'basic_moves'
require_relative 'rook'
require_relative 'bishop'

class Queen < BasicMoves
  attr_reader :data
  
  def initialize(x, y, color)
    symbol = color == "white" ? "♕ " : "♛ "
    @data = { name: "queen", color: color, symbol: symbol, coordinates: {x: x, y: y}, move_count: 0 }
  end

  def valid_move?(origin, destination, all_pieces)
    rook  = Rook.new(0, 0, nil)
    bishop = Bishop.new(0, 0, nil)

    rook.valid_move?(origin, destination, all_pieces) ||
    bishop.valid_move?(origin, destination, all_pieces)
  end
end