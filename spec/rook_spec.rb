require 'rook'
system 'clear' or system 'cls'

describe Rook do
	subject(:rook) { Rook.new(x, y, color) }
	let(:x)        { 1 }
	let(:y)        { 8 }
  let(:color)    { "black" }
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

end