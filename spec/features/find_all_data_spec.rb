require_relative "../../lib/api_service_searching"
require_relative "../fixtures/movie"

RSpec.describe ApiServiceSearching do
  let(:data_set) { Movie.random_collection }

  it "A search with no query string returns all members of the data set" do
    returned = ApiServiceSearching.where(
      data_set,
      nil
    )

    expect(returned).to eq(data_set)
  end
end
