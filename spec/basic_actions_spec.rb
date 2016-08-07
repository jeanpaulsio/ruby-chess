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

end