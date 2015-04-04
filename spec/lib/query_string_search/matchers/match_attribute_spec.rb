require_relative "../../../../lib/query_string_search/abstract_matcher"
require_relative "../../../doubles/search_target"

RSpec.describe MatchAttribute do
  describe "match?" do
    describe "if the target's attribute is not nil" do
      let(:target) { SearchTarget.new(property: "search_value") }

      it "is true" do
        matcher = MatchAttribute.new
        matcher.attribute = :property
        expect(matcher.match?(target)).to be_truthy
      end
    end

    describe "if the target's attribute is true" do
      let(:target) { SearchTarget.new(property: true) }

      it "is true" do
        matcher = MatchAttribute.new
        matcher.attribute = :property
        expect(matcher.match?(target)).to be_truthy
      end
    end

    describe "if the target's attribute returns a collection" do
      let(:target) { SearchTarget.new(property: %w(a b c)) }

      it "is true" do
        matcher = MatchAttribute.new
        matcher.attribute = :property
        expect(matcher.match?(target)).to be_truthy
      end
    end

    describe "if the target's attribute is nil" do
      let(:target) { SearchTarget.new(property: nil) }

      it "is false" do
        matcher = MatchAttribute.new
        matcher.attribute = :property
        expect(matcher.match?(target)).to be_falsey
      end
    end

    describe "if the target's attribute is false" do
      let(:target) { SearchTarget.new(property: false) }

      it "is true" do
        matcher = MatchAttribute.new
        matcher.attribute = :property
        expect(matcher.match?(target)).to be_falsey
      end
    end

    describe "if the target doesn't have the attribute" do
      let(:target) { SearchTarget.new(property: rand) }

      it "is false" do
        matcher = MatchAttribute.new
        matcher.attribute = :bat_attr
        expect(matcher.match?(target)).to be_falsey
      end
    end
  end

  describe "build_me?" do
    let(:search_option) { instance_double(QueryStringSearch::SearchOption) }

    describe "given a value of 'all' or 'true'" do
      it "is true" do
        %w(all true).each do |desired_value|
          allow(search_option).to receive(:desired_value).and_return(desired_value)
          expect(MatchAttribute.build_me?(search_option)).to be_truthy
        end
      end
    end

    describe "given a value that is not 'all' or 'true'" do
      it "is false" do
        %w(1all rue).each do |desired_value|
          allow(search_option).to receive(:desired_value).and_return(desired_value)
          expect(MatchAttribute.build_me?(search_option)).to be_falsey
        end
      end
    end
  end
end
