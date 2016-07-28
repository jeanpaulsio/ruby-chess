require 'bishop'
system 'clear' or system 'cls'

describe Bishop do
	subject(:bishop)   { Bishop.new(x, y, color) }
	let(:x)          { 2 }
	let(:y)          { 8 }
  let(:color)      { "black" }

  # check to see if slope == -1 || 1
  # (y2 - y1) / (x2 - x1)
  describe "#valid_move?" do
  	pending
  end

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
