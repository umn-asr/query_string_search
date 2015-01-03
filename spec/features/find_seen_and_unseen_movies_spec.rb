require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Finding movies" do
  let(:data_set) { Movie.random_collection }

  describe "that have been seen" do
    let(:seen_movies) { data_set.select(&:seen?) }

    it "uses a query-string of 'seen?=true'" do
      results = QueryStringSearch.new(data_set, "seen?=true").results

      expect(results).to eq(seen_movies)
    end
  end

  describe "that have not been seen" do
    let(:unseen_movies) { data_set.select { |d| !d.seen? } }

    it "uses a query-string of 'seen?=false'" do
      results = QueryStringSearch.new(data_set, "seen?=false").results

      expect(results).to eq(unseen_movies)
    end
  end
end
