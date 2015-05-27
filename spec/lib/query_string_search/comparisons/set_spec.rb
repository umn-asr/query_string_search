require_relative "../../../../lib/query_string_search/abstract_comparison"

RSpec.describe QueryStringSearch::SetComparison do
  let(:value) { rand }
  let(:comparison) do
    c = QueryStringSearch::SetComparison.new
    c.subject = value
    c
  end

  describe "comparing for existence" do
    before do
      comparison.operator = "=".to_sym
    end

    describe "target has the data" do
      it "returns true" do
        expect(comparison.compare(value)).to be_truthy
      end
    end

    describe "target does not have the data" do
      it "returns true" do
        expect(comparison.compare(value + 1)).to be_falsey
      end
    end
  end

  describe "comparing for absence" do
    before do
      comparison.operator = :!=
    end

    describe "target has the data" do
      it "returns false" do
        expect(comparison.compare(value)).to be_falsey
      end
    end

    describe "target does not have the data" do
      it "returns true" do
        expect(comparison.compare(value + 1)).to be_truthy
      end
    end
  end
end
