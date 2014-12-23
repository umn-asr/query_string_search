require_relative "../../lib/api_service_searching"
require_relative "../fixtures/movie"

RSpec.describe "Finding data with false attributes" do
  let(:data_set) { Movie.random_collection(10) }
  let(:unseen_movies) { data_set.select { |d| !d.seen? } }
  let(:seen_movies) { data_set.select(&:seen?) }

  it "Returns nil-attribute records with a query-string value of false" do
    returned = ApiServiceSearching.where(
      data_set,
      "seen?=false"
    )

    expect(returned).to eq(unseen_movies)
  end

  it "Returns attribute records with a query-string value of false" do
    returned = ApiServiceSearching.where(
      data_set,
      "seen?=true"
    )

    expect(returned).to eq(seen_movies)
  end
end
