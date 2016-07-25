class Cell
	attr_accessor :data

	def initialize(bg_color, col, row)
		@data = { input: "  ",
			        piece: nil,
			        player_color: nil,
						  bg: bg_color,
					    col: col,
					    row: row
					  }
	end

	def to_s
		"Input: #{@data[:input]}\n" + 
		"Piece: #{@data[:piece]}\n" +
		"Player: #{@data[:player_color]}\n" +
		"Column: #{@data[:col]}\n"  +
		"Row: #{@data[:row]}\n"
	end
end