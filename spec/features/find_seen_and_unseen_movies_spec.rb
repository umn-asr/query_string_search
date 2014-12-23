require_relative "../../lib/api_service_searching"
require_relative "../fixtures/movie"

RSpec.describe "Finding movies" do
  let(:data_set) { Movie.random_collection }

  describe "that have been seen" do
    let(:seen_movies) { data_set.select(&:seen?) }

    it "uses a query-string of 'seen?=true'" do
      returned = ApiServiceSearching.where(
        data_set,
        "seen?=true"
      )

      expect(returned).to eq(seen_movies)
    end
  end

  describe "that have not been seen" do
    let(:unseen_movies) { data_set.select { |d| !d.seen? } }

    it "uses a query-string of 'seen?=false'" do
      returned = ApiServiceSearching.where(
        data_set,
        "seen?=false"
      )

      expect(returned).to eq(unseen_movies)
    end
  end
end
