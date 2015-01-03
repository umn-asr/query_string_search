require_relative "../../../lib/query_string_search/matcher_factory"
require_relative "../../../lib/query_string_search/search_options"

RSpec.describe QueryStringSearch::MatcherFactory do
  let(:matcher_double) { class_double("MatchAttribute") }
  let(:param_double) { double("QueryStringSearch::SearchOptions") }
  let(:build_candidates) { [matcher_double] }

  before do
    allow(param_double).to receive(:search_param).and_return("test_search_param")
    allow(param_double).to receive(:search_type).and_return("test_search_type")
  end

  describe "build" do
    describe "finds a matcher to build" do
      it "builds that matcher and returns it" do
        test_return = Object.new
        expect(matcher_double).to receive(:build_me?).with(param_double.search_type, param_double.search_param).and_return(true)
        expect(matcher_double).to receive(:new).with(param_double.search_type, param_double.search_param).and_return(test_return)
        expect(QueryStringSearch::MatcherFactory.build(param_double, build_candidates)).to eq(test_return)
      end
    end

    describe "does not find a matcher to build" do
      it "returns nil" do
        expect(matcher_double).to receive(:build_me?).and_return(false)
        expect(QueryStringSearch::MatcherFactory.build(param_double, build_candidates)).to be_nil
      end
    end
  end
end
