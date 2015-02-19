require_relative "../../../../lib/query_string_search/abstract_matcher"
require_relative "../../../doubles/search_target"

RSpec.describe MatchMultipleAttributeValues do
  describe "match?" do
    it "matches if the target's attribute is one of the values" do
      target = SearchTarget.new(property: "1994")
      matcher = MatchMultipleAttributeValues.new(:property, "1994|1995")
      expect(matcher.match?(target)).to be_truthy
    end

    it "does not match if the target's attribute is not one of the values" do
      target = SearchTarget.new(property: "199")
      matcher = MatchMultipleAttributeValues.new(:property, "1994|1995")
      expect(matcher.match?(target)).to be_falsey
    end

    describe "if the target doesn't have the attribute" do
      it "is false" do
        target = SearchTarget.new(property: "1994")
        subject = MatchAttribute.new(:bad_attr, "1994|1995")

        expect(subject.match?(target)).to be_falsey
      end
    end
  end

  describe "build_me?" do
    let(:search_option) { instance_double(QueryStringSearch::SearchOption) }

    describe "given a search type and search param that contains a pipe" do
      it "is true" do
        allow(search_option).to receive(:search_type).and_return(rand.to_s)
        allow(search_option).to receive(:search_param).and_return("x|y")
        expect(MatchMultipleAttributeValues.build_me?(search_option)).to be_truthy
      end
    end

    describe "given a search type and search param that starts with a pipe" do
      it "is false" do
        allow(search_option).to receive(:search_type).and_return(rand.to_s)
        allow(search_option).to receive(:search_param).and_return("|x|y")
        expect(MatchMultipleAttributeValues.build_me?(search_option)).to be_falsey
      end
    end

    describe "given a search type without a pipe" do
      it "is false" do
        allow(search_option).to receive(:search_type).and_return(rand.to_s)
        allow(search_option).to receive(:search_param).and_return("xy")
        expect(MatchMultipleAttributeValues.build_me?(search_option)).to be_falsey
      end
    end
  end
end
