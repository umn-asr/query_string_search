require_relative "../../../../lib/query_string_search/abstract_matcher"
require_relative "../../../doubles/search_target"

RSpec.describe MatchMultipleAttributeValues do
  describe "match?" do
    it "matches if the target's attribute is one of the values" do
      target = SearchTarget.new(search_attr: "1994")
      matcher = MatchMultipleAttributeValues.new(:search_attr, "1994|1995")
      expect(matcher.match?(target)).to be_truthy
    end

    it "does not match if the target's attribute is not one of the values" do
      target = SearchTarget.new(search_attr: "199")
      matcher = MatchMultipleAttributeValues.new(:search_attr, "1994|1995")
      expect(matcher.match?(target)).to be_falsey
    end
  end

  describe "build_me?" do
    describe "given a search type and search param that contains a pipe" do
      it "is true" do
        expect(MatchMultipleAttributeValues.build_me?(rand, "x|y")).to be_truthy
      end
    end

    describe "given a search type and search param that starts with a pipe" do
      it "is false" do
        expect(MatchMultipleAttributeValues.build_me?(rand, "|x|y")).to be_falsey
      end
    end

    describe "given a search type without a pipe" do
      it "is false" do
        expect(MatchMultipleAttributeValues.build_me?(rand, "xy")).to be_falsey
      end
    end
  end
end
