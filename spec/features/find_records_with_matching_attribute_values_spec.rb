require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"
require "erb"
include ERB::Util

RSpec.describe "Finding data with matching attribute values" do
  let(:data_set) { Movie.random_collection }
  let(:movies_with_us_country) { data_set.select { |d| d.country == "US" } }

  it "Returns records that match the requested value" do
    results = QueryStringSearch.new(data_set, "country=US").results

    expect(results).to eq(movies_with_us_country)
  end

  it "is case-insensitive" do
    results = QueryStringSearch.new(data_set, "country=us").results

    expect(results).to eq(movies_with_us_country)
  end

  describe "when the values have spaces" do
    let(:random_movie) { data_set.sample }
    # there's a chance that more than one movie has the same title
    let(:movies_with_title) { data_set.select { |d| d.title == random_movie.title } }

    it "matches if the query-string is not escaped" do
      results = QueryStringSearch.new(data_set, "title=#{random_movie.title}").results

      expect(results).to eq(movies_with_title)
    end

    it "matches if the query-string is escaped" do
      results = QueryStringSearch.new(data_set, "title=#{url_encode(random_movie.title)}").results

      expect(results).to eq(movies_with_title)
    end
  end

  describe "when the objects do not respond to the attribute" do
    it "returns an empty result set" do
      results = QueryStringSearch.new(data_set, "monkey=golden").results

      expect { data_set.sample.monkey }.to raise_error(NoMethodError)

      expect(results).to eq([])
    end
  end
end
