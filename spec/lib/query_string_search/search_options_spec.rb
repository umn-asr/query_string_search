require_relative "../../../lib/query_string_search/search_options"

RSpec.describe QueryStringSearch::SearchOptions do
  describe "parse" do
    describe "with a single-element query_string" do
      it "returns a collection of a single search option" do
        option_double = Object.new
        expect(QueryStringSearch::SearchOption).to receive(:new).with("test=filter").and_return(option_double)
        expect(QueryStringSearch::SearchOptions.parse("test=filter")).to eq([option_double])
      end
    end

    describe "with a multi-element query_string" do
      let(:multi_query_string) { "test=filter,test2=test attribute" }
      it "returns a collection of a multiple search options" do
        option_double1 = Object.new
        option_double2 = Object.new
        expect(QueryStringSearch::SearchOption).to receive(:new).with("test=filter").and_return(option_double1)
        expect(QueryStringSearch::SearchOption).to receive(:new).with("test2=test attribute").and_return(option_double2)
        expect(QueryStringSearch::SearchOptions.parse(multi_query_string)).to eq([option_double1, option_double2])
      end
    end

    describe "with a nil" do
      let(:nil_element) { QueryStringSearch::SearchOptions.parse(nil) }
      it "creates a collection with one nil search option" do
        option_double = Object.new
        expect(QueryStringSearch::SearchOption).to receive(:new).with(nil).and_return(option_double)

        expect(QueryStringSearch::SearchOptions.parse(nil)).to eq([option_double])
      end
    end
  end
end
