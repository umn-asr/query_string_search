require_relative "../../../../lib/query_string_search/abstract_matcher"

RSpec.describe MatchAll do
  describe "match?" do
    it "is true" do
      it = MatchAll.new(:other, rand)
      expect(it.match?(rand)).to be_truthy
    end
  end

  describe "build_me?" do
    describe "given a nil search_type and search_param" do
      it "is true" do
        expect(MatchAll.build_me?(nil, nil)).to be_truthy
      end
    end

    describe "given a non-nil search_type or search_param" do
      it "is false" do
        expect(MatchAll.build_me?(rand, nil)).to be_falsey
        expect(MatchAll.build_me?(nil, rand)).to be_falsey
        expect(MatchAll.build_me?(rand, rand)).to be_falsey
      end
    end
  end
end
