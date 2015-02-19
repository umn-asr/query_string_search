require_relative "../../../lib/query_string_search/matcher_factory"
require_relative "../../../lib/query_string_search/search_options"

RSpec.describe QueryStringSearch::MatcherFactory do
  let(:matcher_double) { class_double("MatchAttribute") }
  let(:param_double) { double("QueryStringSearch::SearchOptions") }
  let(:build_candidates) { [matcher_double] }

  before do
    allow(param_double).to receive(:desired_value).and_return("test_search_value")
    allow(param_double).to receive(:attribute).and_return("test_search_attribute")
  end

  describe "build" do
    describe "finds a matcher to build" do
      it "builds that matcher, configures and returns it" do
        test_return = instance_double(QueryStringSearch::AbstractMatcher.matchers.sample)
        expect(test_return).to receive(:attribute=).with("test_search_attribute")
        expect(test_return).to receive(:desired_value=).with("test_search_value")

        expect(matcher_double).to receive(:build_me?).with(param_double).and_return(true)
        expect(matcher_double).to receive(:new).and_return(test_return)
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
