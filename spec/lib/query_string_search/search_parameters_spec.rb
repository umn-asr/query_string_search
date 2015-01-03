require_relative "../../../lib/query_string_search/search_parameters"
require_relative "../../../lib/query_string_search/abstract_matcher"
require_relative "../../../lib/query_string_search/search_options"

RSpec.describe QueryStringSearch::SearchParameters do
  let(:factory) { class_double("QueryStringSearch::MatcherFactory") }
  let(:matchers) { QueryStringSearch::AbstractMatcher.matchers }
  let(:options_double) { double("search_options") }

  describe "build_from_querystring" do
    it "parses the query_string and creates an instance of SearchParameters" do
      expect(QueryStringSearch::SearchOptions).to receive(:parse).with("test=filter").and_return(options_double)
      expect(QueryStringSearch::SearchParameters).to receive(:new).with(options_double, factory, matchers)
      QueryStringSearch::SearchParameters.build_from_querystring("test=filter", factory, matchers)
    end
  end

  describe "new" do
    it "uses the factory to build each parameter" do
      params = QueryStringSearch::SearchOptions.parse("test=filter")
      params.each do |p|
        expect(factory).to receive(:build).with(p, matchers)
      end
      QueryStringSearch::SearchParameters.new(params, factory, matchers)
    end
  end
end
