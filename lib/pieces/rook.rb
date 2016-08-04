require_relative 'basic_moves'
require_relative 'basic_actions'

class Rook < BasicMoves 
  attr_reader :data
  
  def initialize(x, y, color)
    symbol = color == "white" ? "  ♖   " : "  ♜   "
    @data = { name: "rook", color: color, symbol: symbol, 
              coordinates: {x: x, y: y}, move_count: 0, 
              check: false }
  end

  def valid_move?(origin, destination, all_pieces)
    status = false

    if horizontal_slope?(origin, destination)
      status = clear_horizontal_path?(origin, destination, all_pieces) ? true : false
    elsif vertical_slope?(origin, destination)
      status = clear_vertical_path?(origin, destination, all_pieces) ? true : false
    else
      status
    end

    status
  end
end