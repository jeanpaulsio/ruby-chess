require 'rook'
system 'clear' or system 'cls'

describe Rook do
	subject(:rook)   { Rook.new(x, y, color) }
	let(:x)          { 1 }
	let(:y)          { 8 }
  let(:color)      { "black" }

  describe "#valid_move?" do
  	pending
  end

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