require "ostruct"
require_relative "../../../lib/api_service_searching/abstract_matcher"

RSpec.describe AbstractMatcher do
  describe "match?" do
    it "is false" do
      value = rand
      target = OpenStruct.new(other: value)
      it = AbstractMatcher.new(:other, value)
      expect(it.match?(target)).to be_falsey
    end
  end

  describe "build_me?" do
    it "is true" do
      it = AbstractMatcher.build_me?(rand, rand)
      expect(it).to be_truthy
    end
  end

  describe "matchers" do
    it "is has self as last element " do
      it = AbstractMatcher.matchers
      expect(it.last).to eq(AbstractMatcher)
    end
  end
end
