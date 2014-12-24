require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Finding data with nil attributes" do
  let(:data_set) { Movie.random_collection }
  let(:movies_with_nil_ratings) { data_set.select { |d| d.rating.nil? } }

  it "Returns nil-attribute records with a query-string value of false" do
    results = QueryStringSearch.new(data_set, "rating=false").results

    expect(results).to eq(movies_with_nil_ratings)
  end

  it "Returns nil-attribute records with a query-string value of none" do
    results = QueryStringSearch.new(data_set, "rating=none").results

    expect(results).to eq(movies_with_nil_ratings)
  end

  describe "when the objects do not respond to the attribute" do
    it "returns an empty collection" do
      results = QueryStringSearch.new(data_set, "monkey=false").results

      expect { data_set.sample.monkey }.to raise_error(NoMethodError)

      expect(results).to be_empty
    end
  end
end
