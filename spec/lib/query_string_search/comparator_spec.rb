require_relative "../../../lib/query_string_search/comparator"

RSpec.describe QueryStringSearch::Comparator do
  describe "equality" do
    describe "Using an equality operator" do
      describe "compare_with?" do
        it "returns true if the values are equal?" do
          value = rand
          comparison = QueryStringSearch::Comparator.using("=").does(value).compare_with?(value)
          expect(comparison).to be_truthy
        end
      end
    end

    describe "Using the equal? alias" do
      it "returns true if the values are equal?" do
        value = rand
        comparison = QueryStringSearch::Comparator.does(value).equal?(value)
        expect(comparison).to be_truthy
      end
    end
  end

  describe "member of" do
    describe "Using the ∈ operator" do
      describe "compare_with?" do
        it "returns true if the values is a member of the collection" do
          set = [1, 2, 3]
          value = set.sample
          comparison = QueryStringSearch::Comparator.using("&").does(set).compare_with?(value)
          expect(comparison).to be_truthy
        end
      end
    end

    describe "Using the contain? alias" do
      it "returns true if the values is a member of the collection" do
        set = [1, 2, 3]
        value = set.sample
        comparison = QueryStringSearch::Comparator.does(set).contain?(value)
        expect(comparison).to be_truthy
      end
    end
  end
end
