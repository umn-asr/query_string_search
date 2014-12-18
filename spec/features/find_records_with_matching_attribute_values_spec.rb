require_relative "../../lib/api_service_searching"
require_relative "../fixtures/movie"
require "erb"
include ERB::Util

RSpec.describe "Finding data with matching attribute values" do
  let(:data_set) { Movie.random_collection }
  let(:movies_with_us_country) { data_set.select { |d| d.country == "US" } }

  it "Returns records that match the requested value" do
    returned = ApiServiceSearching.where(
      data_set,
      "country=US"
    )

    expect(returned).to eq(movies_with_us_country)
  end

  it "is case-insensitive" do
    returned = ApiServiceSearching.where(
      data_set,
      "country=us"
    )

    expect(returned).to eq(movies_with_us_country)
  end

  describe "when the values have spaces" do
    let(:random_movie) { data_set.sample }
    #there's a chance that more than one movie has the same title
    let(:movies_with_title) { data_set.select { |d| d.title == random_movie.title } }

    it "matches if the query-string is not escaped" do
      returned = ApiServiceSearching.where(
        data_set,
        "title=#{random_movie.title}"
      )

      expect(returned).to eq(movies_with_title)
    end

    it "matches if the query-string is escaped" do
      returned = ApiServiceSearching.where(
        data_set,
        "title=#{url_encode(random_movie.title)}"
      )

      expect(returned).to eq(movies_with_title)
    end
  end
end
