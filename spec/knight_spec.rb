require './lib/pieces/knight'
system 'clear' or system 'cls'

describe Knight do
	subject(:knight) { Knight.new(2, 1, "black") }

	describe "#valid_move?" do
  	pending
  end

  describe "#slope_is_two?" do
  	context "when slope between two points is positive two" do
			let(:origin)      { {x:2, y:1} }
			let(:destination) { {x:3, y:3} }
  		it "returns true" do
  			expect(knight.slope_is_two?(origin, destination)).to be true
  		end
  	end

  	context "when slope between two points is negative two" do
			let(:origin)      { {x:2, y:1} }
			let(:destination) { {x:1, y:3} }
  		it "returns true" do
  			expect(knight.slope_is_two?(origin, destination)).to be true
  		end
  	end
  end

  describe "#slope_is_one_half?" do
  	context "when slope between two points is .5" do
			let(:origin)      { {x:3, y:6} }
			let(:destination) { {x:1, y:5} }
  		it "returns true" do
  			expect(knight.slope_is_one_half?(origin, destination)).to be true
  		end
  	end

  	context "when slope between two points is -.5" do
			let(:origin)      { {x:3, y:6} }
			let(:destination) { {x:5, y:5} }
  		it "returns true" do
  			expect(knight.slope_is_one_half?(origin, destination)).to be true
  		end
  	end
  end

  describe "#valid_distance?" do
  	context "when given a slope of +/- 2" do
			let(:origin)      { {x:2, y:1} }
			let(:destination) { {x:3, y:3} }
  		it "returns true when distance is valid" do
  			expect(knight.valid_distance?(origin, destination)).to be true
  		end
  	end

  	 context "when given a slope of +/- 2" do
			let(:origin)      { {x:2, y:1} }
			let(:destination) { {x:4, y:5} }
  		it "returns false when distance is valid" do
  			expect(knight.valid_distance?(origin, destination)).to be false
  		end
  	end

  	context "when given a slope of +/- .5" do
			let(:origin)      { {x:3, y:6} }
			let(:destination) { {x:5, y:5} }
  		it "returns true when distance is valid" do
  			expect(knight.valid_distance?(origin, destination)).to be true
  		end
  	end

  	 context "when given a slope of +/- .5" do
			let(:origin)      { {x:3, y:6} }
			let(:destination) { {x:7, y:8} }
  		it "returns false when distance is valid" do
  			expect(knight.valid_distance?(origin, destination)).to be false
  		end
  	end
  end
end