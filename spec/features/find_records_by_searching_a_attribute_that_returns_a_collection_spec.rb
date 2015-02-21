require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Finding data based on an attribute that returns a collection" do
  let(:data_set) { Movie.random_collection }

  let(:movies_on_dvd) { data_set.select { |d| d.home_formats.include?("DVD") } }
  let(:movies_on_dvd_or_bd) { data_set.select { |d| d.home_formats.include?("DVD") || d.home_formats.include?("BD") } }

  it "Returns the correct records when searching for one value" do
    query_string = "home_formats=DVD"
    results = QueryStringSearch.new(data_set, query_string).results

    expect(results).to eq(movies_on_dvd)
  end

  it "Returns the correct records when searching for two values" do
    query_string = "home_formats=DVD|BD"
    results = QueryStringSearch.new(data_set, query_string).results

    expect(results).to eq(movies_on_dvd_or_bd)
  end
end
