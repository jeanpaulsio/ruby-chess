require './lib/pieces/basic_actions'
system 'clear' or system 'cls'

describe BasicActions do
	subject(:piece) { BasicActions.new }

	describe "#empty_spot?" do
		context "when destination is empty" do
			let(:destination) { {x:4, y:8} }
			let(:all_pieces)  { [ { coordinates: {x:1, y:7} },
  												  { coordinates: {x:2, y:8} } ]  }

			it "returns true" do
				expect(piece.empty_spot?(destination, all_pieces)).to be true
			end
		end

		context "when destination is occupied" do
			let(:destination) { {x:4, y:8} }
			let(:all_pieces)  { [ { coordinates: {x:1, y:7} },
  												  { coordinates: {x:4, y:8} } ]  }

			it "returns true" do
				expect(piece.empty_spot?(destination, all_pieces)).to be false
			end
		end
	end

	describe "#capture_piece?" do
		context "when player moves to oponent's square" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:4, y:8} }
			let(:pieces)      { [ { color: "white", coordinates: {x:1, y:8} },
  												  { color: "black", coordinates: {x:4, y:8} } ] }
			it "captures opponents piece" do
				expect(piece.capture_piece?(origin, destination, pieces)).to be true
			end
		end
	end

	describe "#friendly_fire?" do
		context "when player moves to own square" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:4, y:8} }
			let(:pieces)      { [ { color: "white", coordinates: {x:1, y:8} },
  												  { color: "white", coordinates: {x:4, y:8} } ] }
			it "returns true" do
				expect(piece.friendly_fire?(origin, destination, pieces)).to be true
			end
		end
	end
end