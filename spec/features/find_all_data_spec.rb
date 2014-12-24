require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Searching for all data" do
  let(:data_set) { Movie.random_collection }

  it "Uses no query string " do
    results = QueryStringSearch.new(data_set, nil).results
    expect(results).to eq(data_set)
  end
end
