require_relative "../../lib/api_service_searching"
require_relative "../fixtures/movie"

RSpec.describe "Finding data with nil attributes" do
  let(:data_set) { Movie.random_collection }
  let(:movies_with_nil_ratings) { data_set.select { |d| d.rating.nil? } }

  it "Returns nil-attribute records with a query-string value of false" do
    returned = ApiServiceSearching.where(
      data_set,
      "rating=false"
    )

    expect(returned).to eq(movies_with_nil_ratings)
  end

  it "Returns nil-attribute records with a query-string value of none" do
    returned = ApiServiceSearching.where(
      data_set,
      "rating=none"
    )

    expect(returned).to eq(movies_with_nil_ratings)
  end
end
