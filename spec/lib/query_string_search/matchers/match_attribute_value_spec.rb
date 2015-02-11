require_relative "../../../../lib/query_string_search/abstract_matcher"
require_relative "../../../doubles/search_target"

RSpec.describe MatchAttributeValue do
  describe "match?" do
    describe "given a target with an attribute that matches the Parameter's attribute" do
      let(:target) { SearchTarget.new(property: "search_value") }
      let(:subject) { MatchAttributeValue.new(:property, "search_value") }

      it "returns true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "given a value with spaces" do
      let(:target) { SearchTarget.new(property: "search value") }
      let(:subject) { MatchAttributeValue.new(:property, "search_value") }

      it "returns true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "given a target with an attribute that does not match the Parameter's attribute" do
      let(:target) { SearchTarget.new(property: "other_value") }
      let(:subject) { MatchAttributeValue.new(:property, "search_value") }

      it "returns false" do
        expect(subject.match?(target)).to be_falsey
      end
    end

    describe "if the target doesn't have the attribute" do
      let(:target) { SearchTarget.new(property: "search_value") }
      let(:subject) { MatchAttribute.new(:bad_attr, "search_value") }

      it "is false" do
        expect(subject.match?(target)).to be_falsey
      end
    end
  end

  describe "build_me?" do
    describe "given a non-nil search_type and search_param" do
      it "is true" do
        expect(MatchAttributeValue.build_me?(rand.to_s, rand.to_s)).to be_truthy
      end
    end

    describe "given a nil search_type or search_param" do
      it "is false" do
        expect(MatchAttributeValue.build_me?(rand.to_s, nil)).to be_falsey
        expect(MatchAttributeValue.build_me?(nil, rand.to_s)).to be_falsey
        expect(MatchAttributeValue.build_me?(nil, nil)).to be_falsey
      end
    end
  end
end
