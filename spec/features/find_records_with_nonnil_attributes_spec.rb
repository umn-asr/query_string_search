require_relative "../../lib/api_service_searching"
require_relative "../fixtures/movie"

RSpec.describe "Finding data with non-nil attributes" do
  let(:data_set) { Movie.random_collection(200) }
  let(:movies_with_non_nil_ratings) { data_set.select { |d| !d.rating.nil? } }

  it "Returns non-nil-attribute records with a query-string value of true" do
    returned = ApiServiceSearching.where(
      data_set,
      "rating=true"
    )

    expect(returned).to eq(movies_with_non_nil_ratings)
  end

  it "Returns non-nil-attribute records with a query-string value of all" do
    returned = ApiServiceSearching.where(
      data_set,
      "rating=all"
    )

    expect(returned).to eq(movies_with_non_nil_ratings)
  end

  describe "when the objects do not respond to the attribute" do
    it "returns an empty collection" do
      returned = ApiServiceSearching.where(
        data_set,
        "monkey=true"
      )

      expect { data_set.sample.monkey }.to raise_error(NoMethodError)

      expect(returned).to be_empty
    end
  end
end
