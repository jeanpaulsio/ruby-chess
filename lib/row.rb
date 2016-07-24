require_relative 'cell'

class Row
	def find_cell_color(col, row)
		if col.odd? && row.even? || col.even? && row.odd?
			:white
		elsif col.even? && row.even? || col.odd? && row.odd?
			:black
		end
	end

	# returns array of 8 cells
	def make_row(num)
		arr = []
		97.upto(104) do |i|
			color    = find_cell_color(i, num) 
			letter   = i.chr
			var_name = "@" + letter + num.to_s
			instance_variable_set(var_name, (Cell.new(color, letter, num)))
			
			arr << instance_variable_get(var_name)
		end
		arr
	end

	def stuff(iv)
		var_name = "@" + iv
		puts "b8 = #{instance_variable_get(var_name).data[:input]}"
	end
end