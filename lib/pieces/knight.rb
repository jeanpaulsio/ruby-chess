class Knight
  attr_reader :data
  
  def initialize(x, y, color)
    symbol = color == "white" ? "  ♘   " : "  ♞   "
    @data = { name: "knight", color: color, symbol: symbol, 
              coordinates: {x: x, y: y}, move_count: 0, 
              check: false }
  end

  def valid_move?(origin, destination, all_pieces=[])
    ( slope_is_two?(origin, destination) || 
      slope_is_one_half?(origin, destination) ) &&
      valid_distance?(origin, destination)
  end

  def slope_is_two?(origin, destination)
    y2, y1 = destination[:y], origin[:y]
    x2, x1 = destination[:x], origin[:x]

    return false if x2 == x1
    ((y2 - y1)/(x2 - x1)).abs == 2
  end

  def slope_is_one_half?(origin, destination)
    y2, y1 = destination[:y], origin[:y]
    x2, x1 = destination[:x], origin[:x]

    return false if x2 == x1
    ((y2 - y1)/(x2 - x1.to_f)).abs == 0.5
  end

  def valid_distance?(origin, destination)
    y2, y1 = destination[:y], origin[:y]
    x2, x1 = destination[:x], origin[:x]

    ( ((y2 - y1).abs == 1) && ((x2 - x1).abs == 2) ) ||
    ( ((y2 - y1).abs == 2) && ((x2 - x1).abs == 1) )
  end
end