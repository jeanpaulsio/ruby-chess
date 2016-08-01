require './lib/pieces/bishop'
require './lib/pieces/rook'
system 'clear' or system 'cls'

describe Bishop do
	subject(:bishop) { Bishop.new(x, y, color) }
	let(:x)          { 2 }
	let(:y)          { 8 }
  let(:color)      { "black" }

  # check to see if slope == -1 || 1
  # (y2 - y1) / (x2 - x1)
  
  describe "#positive_slope?" do
  	context "when traversing upward on positive slope" do
			let(:origin)      { {x:3, y:1} }
			let(:destination) { {x:7, y:5} }

			it "returns true if slope equals 1" do
				expect(bishop.positive_slope?(origin, destination)).to be true
			end
		end
		context "when traversing downward on positive slope" do
			let(:origin)      { {x:7, y:5} }
			let(:destination) { {x:3, y:1} }

			it "returns true if slope equals 1" do
				expect(bishop.positive_slope?(origin, destination)).to be true
			end
		end
  end

  describe "#negative_slope?" do
  	context "when traversing upward on negative slope" do
			let(:origin)      { {x:6, y:1} }
			let(:destination) { {x:2, y:5} }

			it "returns true if slope equals -1" do
				expect(bishop.negative_slope?(origin, destination)).to be true
			end
		end
		context "when traversing downward on negative slope" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:5, y:4} }

			it "returns true if slope equals -1" do
				expect(bishop.negative_slope?(origin, destination)).to be true
			end
		end
  end

  describe "#bounding_box" do
  	context "when given (x1,y1) and (x2,y2)" do
 			let(:origin)      { {x:3, y:2} }
			let(:destination) { {x:6, y:5} }
			let(:set1)        { [ { coordinates: {x:4, y:4} },
  												  { coordinates: {x:6, y:2} },
  												  { coordinates: {x:1, y:2} } ] }

  		it "returns coordinates on board within box area of coordinates" do
  			actual = bishop.bounding_box(origin, destination, set1)
  			expect(actual).to eq( [{ coordinates: {x:4, y:4} },
  												     { coordinates: {x:6, y:2} } ] )
  		end
  	end
  end

  describe "#clear_positive_slope?" do
  	context "when given values within square area" do
 			let(:origin)      { {x:3, y:2} }
			let(:set1)        { [ { coordinates: {x:4, y:4} },
  												  { coordinates: {x:6, y:2} } ] }
			let(:set2)        { [ { coordinates: {x:4, y:3} },
  												  { coordinates: {x:6, y:2} } ] }

  		it "returns true if clear path between origin and destination" do
  			with_set1 = bishop.clear_positive_slope?(origin, set1)
  			with_set2 = bishop.clear_positive_slope?(origin, set2)
  			expect(with_set1).to be true
  			expect(with_set2).to be false
  		end
  	end
  end

  describe "#clear_negative_slope?" do
  	context "when given values within square area" do
 			let(:origin)      { {x:3, y:5} }
			let(:set1)        { [ { coordinates: {x:3, y:3} },
  												  { coordinates: {x:6, y:4} } ] }
			let(:set2)        { [ { coordinates: {x:4, y:3} },
  												  { coordinates: {x:6, y:2} } ] }

  		it "returns true if clear path between origin and destination" do
  			with_set1 = bishop.clear_negative_slope?(origin, set1)
  			with_set2 = bishop.clear_negative_slope?(origin, set2)
  			expect(with_set1).to be true
  			expect(with_set2).to be false
  		end
  	end
  end
end

describe Rook do
	subject(:rook)   { Rook.new(x, y, color) }
	let(:x)          { 1 }
	let(:y)          { 8 }
  let(:color)      { "black" }

	describe "#vertical_slope?" do
		context "when x1 = x2" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:1, y:4} }

			it "returns true" do
				expect(rook.vertical_slope?(origin, destination)).to be true
				expect(rook.vertical_slope?(origin, {x:2, y:8} )).to be false
			end
		end
	end

	describe "#horizontal_slope" do
		context "when y1 = y2" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:4, y:8} }

			it "returns true" do
				expect(rook.horizontal_slope?(origin, destination)).to be true
				expect(rook.horizontal_slope?(origin, {x:4, y:7} )).to be false
			end
		end
	end

	#check paths vertically
  describe "#clear_vertical_path?" do
		context "when moving downward on the board" do
			let(:origin)      { {x:1, y:6} }
			let(:destination) { {x:1, y:1} }
			let(:set1)        { [ { coordinates: {x:1, y:7} },
  												  { coordinates: {x:2, y:8} } ] }
			let(:set2)        { [ { coordinates: {x:1, y:5} },
  												  { coordinates: {x:2, y:8} } ] }
			it "returns true if path is clear" do
  			actual = rook.clear_vertical_path?(origin, destination, set1)
				expect(actual).to be true
			end
			it "returns false if path is not clear" do
				actual = rook.clear_vertical_path?(origin, destination, set2)
				expect(actual).to be false
			end
		end

		context "when moving upward on the board" do
			let(:origin)      { {x:1, y:1} }
			let(:destination) { {x:1, y:7} }
			let(:set1)        { [ { coordinates: {x:1, y:7} },
  												  { coordinates: {x:2, y:8} } ] }
			let(:set2)        { [ { coordinates: {x:1, y:5} },
  												  { coordinates: {x:2, y:8} } ] }
  		it "returns true if path is clear" do
  			actual = rook.clear_vertical_path?(origin, destination, set1)
				expect(actual).to be true
  		end	
 			it "returns false if path is not clear" do
				actual = rook.clear_vertical_path?(origin, destination, set2)
				expect(actual).to be false
			end
		end

	end

	#checks paths horizontally
	describe "#clear_horizontal_path?" do
		context "when moving left to right" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:4, y:8} }
			let(:set1)        { [ { coordinates: {x:5, y:8} },
  												  { coordinates: {x:7, y:8} } ] }
			let(:set2)        { [ { coordinates: {x:3, y:8} },
  												  { coordinates: {x:4, y:8} } ] }
			it "returns true if path is clear" do
  			actual = rook.clear_horizontal_path?(origin, destination, set1)
				expect(actual).to be true
			end
			it "returns false if path is not clear" do
				actual = rook.clear_horizontal_path?(origin, destination, set2)
				expect(actual).to be false
			end
		end

		context "when moving right to left" do
			let(:origin)      { {x:4, y:8} }
			let(:destination) { {x:1, y:8} }
			let(:set1)        { [ { coordinates: {x:5, y:8} },
  												  { coordinates: {x:7, y:8} } ] }
			let(:set2)        { [ { coordinates: {x:3, y:8} },
  												  { coordinates: {x:4, y:8} } ] }
			it "returns true if path is clear" do
  			actual = rook.clear_horizontal_path?(origin, destination, set1)
				expect(actual).to be true
			end
			it "returns false if path is not clear" do
				actual = rook.clear_horizontal_path?(origin, destination, set2)
				expect(actual).to be false
			end
		end
	end
end
