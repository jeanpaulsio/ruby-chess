require './lib/pieces/king'
system 'clear' or system 'cls'

describe King do
	subject(:king) { King.new(5, 1, "white") }

	describe "#valid_move?" do
		context "when given a valid destination" do
			let(:origin) { {x:4, y:4} }
			let(:set1)   { {x:3, y:3} }
			let(:set2)   { {x:3, y:4} }
			let(:set3)   { {x:3, y:5} }
			let(:set4)   { {x:4, y:3} }
			let(:set5)   { {x:4, y:5} }
			let(:set6)   { {x:5, y:3} }
			let(:set7)   { {x:5, y:4} }
			let(:set8)   { {x:5, y:5} }
			it "returns true" do
				expect(king.valid_move?(origin, set1)).to be true
				expect(king.valid_move?(origin, set2)).to be true
				expect(king.valid_move?(origin, set3)).to be true
				expect(king.valid_move?(origin, set4)).to be true
				expect(king.valid_move?(origin, set5)).to be true
				expect(king.valid_move?(origin, set6)).to be true
				expect(king.valid_move?(origin, set7)).to be true
				expect(king.valid_move?(origin, set8)).to be true
			end
		end

		context "when given an invalid destination" do
			let(:origin) { {x:4, y:4} }
			let(:set1)   { {x:2, y:2} }
			let(:set2)   { {x:6, y:7} }
			it "returns false" do
				expect(king.valid_move?(origin, set1)).to be false
				expect(king.valid_move?(origin, set2)).to be false
			end
		end
	end
end