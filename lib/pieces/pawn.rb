class Pawn
  attr_reader :data
  
  def initialize(x, y, color)
    symbol = color == "white" ? "♙ " : "♟ "
    @data = { name: "pawn", color: color, symbol: symbol, 
              coordinates: {x: x, y: y}, move_count: 0, 
              enpassant: false }
  end

  def valid_move?(origin, destination, all_pieces)
    ( move_forward(origin, destination)  && spot_is_empty(destination, all_pieces)  ) ||
    ( move_diagonal(origin, destination) && !spot_is_empty(destination, all_pieces) )
  end

  def move_forward(origin, destination)
    y2, y1 = destination[:y], origin[:y]
    x2, x1 = destination[:x], origin[:x]

    if @data[:move_count] < 1
      if @data[:color] == "white"
        ( (x2 == x1) && (y2 - y1 == 2) ) ||
        ( (x2 == x1) && (y2 - y1 == 1) )
      else
        ( (x2 == x1) && (y2 - y1 == -2) ) ||
        ( (x2 == x1) && (y2 - y1 == -1) )
      end
    else
      if @data[:color] == "white"
        ( (x2 == x1) && (y2 - y1 == 1) )
      else
        ( (x2 == x1) && (y2 - y1 == -1) )
      end
    end
  end

  def move_diagonal(origin, destination)
    y2, y1 = destination[:y], origin[:y]
    x2, x1 = destination[:x], origin[:x]

    ( (y2 - y1 == -1) && (x2 - x1 == -1) ) ||
    ( (y2 - y1 ==  1) && (x2 - x1 == -1) ) ||
    ( (y2 - y1 == -1) && (x2 - x1 ==  1) ) ||
    ( (y2 - y1 ==  1) && (x2 - x1 ==  1) )
  end
  
  def spot_is_empty(destination, all_pieces)
    target = all_pieces.select { |piece| piece[:coordinates] == destination }
    target.empty? ? true : false
  end
end