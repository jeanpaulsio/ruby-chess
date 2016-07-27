require 'rook'
system 'clear' or system 'cls'

describe Rook do
	subject(:rook)   { Rook.new(x, y, color) }
	let(:x)          { 1 }
	let(:y)          { 8 }
  let(:color)      { "black" }

	describe "#valid_move?" do
		context "when given two coodinates with same x-value" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:1, y:4} }

			it "returns true" do
				expect(rook.valid_move?(origin, destination)).to be true
			end
		end

		context "when given two coordinates with same y-value" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:4, y:8} }

			it "returns true" do
				expect(rook.valid_move?(origin, destination)).to be true
			end
		end

		context "when neither x nor y coordinates match" do
			let(:origin)      { {x:1, y:7} }
			let(:destination) { {x:4, y:8} }

			it "returns false" do
				expect(rook.valid_move?(origin, destination)).to be false
			end
		end
	end

	describe "#empty_spot?" do
		context "when destination is empty" do
			let(:destination) { {x:4, y:8} }
			let(:all_pieces)  { [ { coordinates: {:x=>1, :y=>7} },
  												  { coordinates: {:x=>2, :y=>8} } ]  }

			it "returns true" do
				expect(rook.empty_spot?(destination, all_pieces)).to be true
			end
		end

		context "when destination is occupied" do
			let(:destination) { {x:4, y:8} }
			let(:all_pieces)  { [ { coordinates: {:x=>1, :y=>7} },
  												  { coordinates: {:x=>4, :y=>8} } ]  }

			it "returns true" do
				expect(rook.empty_spot?(destination, all_pieces)).to be false
			end
		end
	end

	describe "#vertical_slope?" do
		context "when #valid_move? and x1 = x2" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:1, y:4} }

			it "returns true" do
				expect(rook.vertical_slope?(origin, destination)).to be true
				expect(rook.vertical_slope?(origin, {x:2, y:8} )).to be false
			end
		end
	end

	describe "#horizontal_slope" do
		context "when #valid_move? and y1 = y2" do
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
			let(:set1)        { [ { coordinates: {:x=>1, :y=>7} },
  												  { coordinates: {:x=>2, :y=>8} } ] }
			let(:set2)        { [ { coordinates: {:x=>1, :y=>5} },
  												  { coordinates: {:x=>2, :y=>8} } ] }
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
			let(:set1)        { [ { coordinates: {:x=>1, :y=>7} },
  												  { coordinates: {:x=>2, :y=>8} } ] }
			let(:set2)        { [ { coordinates: {:x=>1, :y=>5} },
  												  { coordinates: {:x=>2, :y=>8} } ] }
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
			let(:set1)        { [ { coordinates: {:x=>5, :y=>8} },
  												  { coordinates: {:x=>7, :y=>8} } ] }
			let(:set2)        { [ { coordinates: {:x=>3, :y=>8} },
  												  { coordinates: {:x=>4, :y=>8} } ] }
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
			let(:set1)        { [ { coordinates: {:x=>5, :y=>8} },
  												  { coordinates: {:x=>7, :y=>8} } ] }
			let(:set2)        { [ { coordinates: {:x=>3, :y=>8} },
  												  { coordinates: {:x=>4, :y=>8} } ] }
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

	describe "#capture_piece?" do
		context "when player moves to oponent's square" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:4, y:8} }
			let(:pieces)      { [ { color: "white", coordinates: {:x=>1, :y=>8} },
  												  { color: "black", coordinates: {:x=>4, :y=>8} } ] }
			it "captures opponents piece" do
				expect(rook.capture_piece?(origin, destination, pieces)).to be true
			end
		end
	end

	describe "#friendly_fire?" do
		context "when player moves to own square" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:4, y:8} }
			let(:pieces)      { [ { color: "white", coordinates: {:x=>1, :y=>8} },
  												  { color: "white", coordinates: {:x=>4, :y=>8} } ] }
			it "returns true" do
				expect(rook.friendly_fire?(origin, destination, pieces)).to be true
			end
		end
	end
end