require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Finding data with inequality matchers" do

  describe "Allows searching for values greater than a number" do
    let(:data_set) { Movie.random_collection }
    let(:movies_with_more_than_one_star) { data_set.select { |d| d.star_rating > 1 } }

    it "Returns records that match the requested value" do
      results = QueryStringSearch.new(data_set, "star_rating>1").results

      expect(results).to eq(movies_with_more_than_one_star)
    end
  end

  describe "Allows searching for values less than a number" do
    let(:data_set) { Movie.random_collection }
    let(:movies_with_fewer_than_three_stars) { data_set.select { |d| d.star_rating < 3 } }

    it "Returns records that match the requested value" do
      results = QueryStringSearch.new(data_set, "star_rating<3").results

      expect(results).to eq(movies_with_more_than_one_star)
    end
  end

  describe "Allows searching for values greater than or equal to a number" do
    let(:data_set) { Movie.random_collection }
    let(:movies_with_two_or_more_stars) { data_set.select { |d| d.star_rating >= 2 } }

    it "Returns records that match the requested value" do
      results = QueryStringSearch.new(data_set, "star_rating>=2").results

      expect(results).to eq(movies_with_more_than_one_star)
    end
  end

  describe "Allows searching for values less than or equal to a number" do
    let(:data_set) { Movie.random_collection }
    let(:movies_with_four_or_fewer_stars) { data_set.select { |d| d.star_rating <= 4 } }

    it "Returns records that match the requested value" do
      results = QueryStringSearch.new(data_set, "star_rating<=4").results

      expect(results).to eq(movies_with_more_than_one_star)
    end
  end
end
