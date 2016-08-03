class BasicMoves
  def vertical_slope?(origin, destination)
    origin[:x] == destination[:x]
  end

  def horizontal_slope?(origin, destination)
    origin[:y] == destination[:y]
  end

  def clear_vertical_path?(origin, destination, all_pieces)
    x1, x2 = origin[:x], destination[:x]
    y1     = origin[:y] < destination[:y] ? origin[:y] : destination[:y]
    y2     = origin[:y] < destination[:y] ? destination[:y] : origin[:y]
    y1    += 1

    x_values = all_pieces.select { |piece| piece[:coordinates][:x] == x1 }
    x_values.none? { |piece| ((y1...y2).include? piece[:coordinates][:y]) }
  end

  def clear_horizontal_path?(origin, destination, all_pieces)
    y1, y2 = origin[:y], destination[:y]
    x1     = origin[:x] < destination[:x] ? origin[:x] : destination[:x]
    x2     = origin[:x] < destination[:x] ? destination[:x] : origin[:x]
    x1    += 1

    y_values = all_pieces.select { |piece| piece[:coordinates][:y] == y1 }
    y_values.none? { |piece| ((x1...x2).include? piece[:coordinates][:x]) }
  end

  def positive_slope?(origin, destination)
    y2, y1 = destination[:y], origin[:y]
    x2, x1 = destination[:x], origin[:x]

    return false if x2 == x1
    (y2 - y1)/(x2 - x1.to_f) ==  1
  end

  def negative_slope?(origin, destination)
    y2, y1 = destination[:y], origin[:y]
    x2, x1 = destination[:x], origin[:x]

    return false if x2 == x1
    (y2 - y1)/(x2 - x1.to_f) == -1
  end

  def bounding_box(origin, destination, all_pieces)
    x1 = origin[:x] < destination[:x] ? origin[:x] : destination[:x]
    x2 = origin[:x] < destination[:x] ? destination[:x] : origin[:x]
    y1 = origin[:y] < destination[:y] ? origin[:y] : destination[:y]
    y2 = origin[:y] < destination[:y] ? destination[:y] : origin[:y]

    bounded_values = all_pieces.select do |piece|
      piece[:coordinates][:x].between?(x1, x2) &&
      piece[:coordinates][:y].between?(y1, y2)
    end
  end

  def clear_positive_slope?(origin, destination, bounded_values)
    x1, y1 = origin[:x], origin[:y]

    bounded_values.delete_if { |i| i[:coordinates] == destination }

    bounded_values.none? do |i| 
      ((i[:coordinates][:y] - y1)/(i[:coordinates][:x] - x1.to_f)) == 1
    end
  end

  def clear_negative_slope?(origin, destination, bounded_values)
    x1, y1 = origin[:x], origin[:y]
    
    bounded_values.delete_if { |i| i[:coordinates] == destination }
    
    bounded_values.none? do |i| 
      ((i[:coordinates][:y] - y1)/(i[:coordinates][:x] - x1.to_f)) == -1
    end
  end
end