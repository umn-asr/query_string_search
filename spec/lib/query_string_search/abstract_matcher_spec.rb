require "ostruct"
require_relative "../../../lib/query_string_search/abstract_matcher"

RSpec.describe QueryStringSearch::AbstractMatcher do
  describe "match?" do
    it "is false" do
      value = rand
      target = OpenStruct.new(other: value)
      it = QueryStringSearch::AbstractMatcher.new
      it.attribute = :other
      it.desired_value = value
      it.operator = "="
      expect(it.match?(target)).to be_falsey
    end
  end

  describe "build_me?" do
    it "is true" do
      it = QueryStringSearch::AbstractMatcher.build_me?(Object.new)
      expect(it).to be_truthy
    end
  end

  describe "matchers" do
    it "is has self as last element " do
      it = QueryStringSearch::AbstractMatcher.matchers
      expect(it.last).to eq(QueryStringSearch::AbstractMatcher)
    end
  end
end
