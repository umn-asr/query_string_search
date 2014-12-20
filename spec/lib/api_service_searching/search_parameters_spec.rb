require_relative "../../../lib/api_service_searching/search_parameters"
require_relative "../../../lib/api_service_searching/abstract_matcher"
require_relative "../../../lib/api_service_searching/search_options"

RSpec.describe SearchParameters do
  let(:factory) { class_double("MatcherFactory") }
  let(:matchers) { AbstractMatcher.matchers }
  let(:options_double) { double("search_options") }

  describe "build_from_querystring" do
    it "parses the query_string and creates an instance of SearchParameters" do
      expect(SearchOptions).to receive(:parse).with("test=filter").and_return(options_double)
      expect(SearchParameters).to receive(:new).with(options_double, factory, matchers)
      SearchParameters.build_from_querystring("test=filter", factory, matchers)
    end
  end

  describe "new" do
    it "uses the factory to build each parameter" do
      params = SearchOptions.parse("test=filter")
      params.each do |p|
        expect(factory).to receive(:build).with(p, matchers)
      end
      SearchParameters.new(params, factory, matchers)
    end
  end
end
