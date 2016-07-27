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
		context "when traversing upward on positive slope" do
			let(:origin)      { {x:3, y:1} }
			let(:destination) { {x:7, y:5} }

			it "returns true if slope equals 1" do
				expect(bishop.valid_move?(origin, destination)).to be true
			end
		end
		context "when traversing downward on positive slope" do
			let(:origin)      { {x:7, y:5} }
			let(:destination) { {x:3, y:1} }

			it "returns true if slope equals 1" do
				expect(bishop.valid_move?(origin, destination)).to be true
			end
		end
  
		context "when traversing upward on negative slope" do
			let(:origin)      { {x:6, y:1} }
			let(:destination) { {x:2, y:5} }

			it "returns true if slope equals -1" do
				expect(bishop.valid_move?(origin, destination)).to be true
			end
		end
		context "when traversing downward on negative slope" do
			let(:origin)      { {x:1, y:8} }
			let(:destination) { {x:5, y:4} }

			it "returns true if slope equals -1" do
				expect(bishop.valid_move?(origin, destination)).to be true
			end
		end

  end
end
