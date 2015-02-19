require_relative "../../../lib/query_string_search/search_option"

RSpec.describe QueryStringSearch::SearchOption do
  describe "new" do
    describe "with equality operator" do
      let(:equal_query) { "test=2" }

      it "correctly splits the attribute, value and operator" do
        equal_option = QueryStringSearch::SearchOption.new("test=2")
        expect(equal_option.search_type).to eq(:test)
        expect(equal_option.search_param).to eq("2")
        expect(equal_option.operator).to eq("=")
      end
    end

    describe "with inequality operators" do
      let(:less_than_query_string) { "test<1" }
      let(:greater_than_or_equal_query) { "test>=2" }

      it "correctly splits the attribute, value and operator" do
        less_than = QueryStringSearch::SearchOption.new(less_than_query_string)
        greater_or_equal = QueryStringSearch::SearchOption.new(greater_than_or_equal_query)

        expect(less_than.search_type).to eq(:test)
        expect(less_than.search_param).to eq("1")
        expect(less_than.operator).to eq("<")

        expect(greater_or_equal.search_type).to eq(:test)
        expect(greater_or_equal.search_param).to eq("2")
        expect(greater_or_equal.operator).to eq(">=")
      end
    end
  end
end
