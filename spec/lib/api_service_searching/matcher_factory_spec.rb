require_relative "../../../lib/api_service_searching/matcher_factory"
require_relative "../../../lib/api_service_searching/search_options"

RSpec.describe MatcherFactory do
  let(:matcher_double) { class_double("MatchAttribute") }
  let(:param_double) { double("SearchOptions") }
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
        expect(MatcherFactory.build(param_double, build_candidates)).to eq(test_return)
      end
    end

    describe "does not find a matcher to build" do
      it "returns nil" do
        expect(matcher_double).to receive(:build_me?).and_return(false)
        expect(MatcherFactory.build(param_double, build_candidates)).to be_nil
      end
    end
  end
end
