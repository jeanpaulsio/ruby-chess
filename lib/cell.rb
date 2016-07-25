class Cell
	attr_accessor :data

	def initialize(bg_color, col, row)
		@data = {input: "  ",
			       piece: nil,
						    bg: bg_color,
					     col: col,
					     row: row
					  }
	end
end