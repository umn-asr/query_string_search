require_relative "../../../../lib/query_string_search/abstract_matcher"

RSpec.describe MatchAll do
  describe "match?" do
    it "is true" do
      it = MatchAll.new
      it.attribute = :other
      it.desired_value = rand
      expect(it.match?(rand)).to be_truthy
    end
  end

  describe "build_me?" do
    let(:search_option) { instance_double(QueryStringSearch::SearchOption) }

    describe "given a nil search_type and search_param" do
      it "is true" do
        allow(search_option).to receive(:search_type).and_return(nil)
        allow(search_option).to receive(:search_param).and_return(nil)

        expect(MatchAll.build_me?(search_option)).to be_truthy
      end
    end

    describe "given a non-nil search_type or search_param" do
      it "is false" do
        allow(search_option).to receive(:search_type).and_return(rand)
        allow(search_option).to receive(:search_param).and_return(nil)
        expect(MatchAll.build_me?(search_option)).to be_falsey

        allow(search_option).to receive(:search_type).and_return(nil)
        allow(search_option).to receive(:search_param).and_return(rand)
        expect(MatchAll.build_me?(search_option)).to be_falsey

        allow(search_option).to receive(:search_type).and_return(rand)
        allow(search_option).to receive(:search_param).and_return(rand)
        expect(MatchAll.build_me?(search_option)).to be_falsey
      end
    end
  end
end
