require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Finding data that match multiple parameters" do
  let(:data_set) { Movie.random_collection }
  let(:random_movie) { data_set.sample }

  let(:movies_with_country) { data_set.select { |d| d.country == random_movie.country } }
  let(:movies_with_year) { data_set.select { |d| d.year == random_movie.year } }
  let(:movies_with_rating) { data_set.select { |d| d.rating == random_movie.rating } }

  let(:expected) { movies_with_country & movies_with_year & movies_with_rating }

  it "Returns records that match the requested value" do
    query_string = "country=#{random_movie.country},year=#{random_movie.year},rating=#{random_movie.rating || 'none'}"
    results = QueryStringSearch.new(data_set, query_string).results

    expect(expected).to eq(results)
  end

  describe "when the objects do not respond one of the attributes" do
    it "returns an empty collection" do
      query_string = "country=#{random_movie.country},year=#{random_movie.year},rating=#{random_movie.rating},monkey=golden"
      results = QueryStringSearch.new(data_set, query_string).results

      expect { data_set.sample.monkey }.to raise_error(NoMethodError)

      expect(results).to eq([])
    end
  end
end
