require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Finding data that matches one of many attributes" do
  let(:data_set) { Movie.random_collection }
  let(:movies_in_1994_or_1995) { data_set.select { |d| %w(1994 1995).include?(d.year) } }

  it "Returns records that match the requested value" do
    results = QueryStringSearch.new(data_set, "year=1994|1995").results

    expect(results).to eq(movies_in_1994_or_1995)
  end
end
