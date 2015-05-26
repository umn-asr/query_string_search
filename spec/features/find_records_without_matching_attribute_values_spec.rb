require_relative "../../lib/query_string_search"
require_relative "../fixtures/movie"

RSpec.describe "Finding data that does not have the requested value" do
  let(:data_set) { Movie.random_collection }

  it "Returns records that do not have a single value " do
    expected_results = data_set.select { |d| d.year != "1994" }
    actual_results = QueryStringSearch.new(data_set, "year!=1994").results
    expect(actual_results).to eq(expected_results)
  end

  it "Returns records that do not have a value in a collection " do
    expected_results = data_set.select { |d| !d.home_formats.include?("BD") }
    actual_results = QueryStringSearch.new(data_set, "home_formats!=BD").results
    expect(actual_results).to eq(expected_results)
  end

  it "Returns records that do not have any of the requested values " do
    expected_results = data_set.select { |d| !%w(1994 1995).include?(d.year) }
    actual_results = QueryStringSearch.new(data_set, "year!=1994|1995").results
    expect(actual_results).to eq(expected_results)
  end

  it "Returns records that do not have any of the requested values in their collection" do
    expected_results = data_set.select { |d| !d.home_formats.include?("BD") && !d.home_formats.include?("DVD") }
    actual_results = QueryStringSearch.new(data_set, "home_formats!=BD|DVD").results
    expect(actual_results).to eq(expected_results)
  end
end
