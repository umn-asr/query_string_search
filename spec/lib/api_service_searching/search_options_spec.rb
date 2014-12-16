require_relative "../../../lib/api_service_searching/search_options"

RSpec.describe SearchOptions do
  describe "parse" do
    describe "with a single-element and multi-element query_string" do
      let(:single_query_string) { "test=filter" }
      let(:multi_query_string) { "test=filter,test2=filter2" }
      let(:single_element) { SearchOptions.parse(single_query_string) }
      let(:multi_element) { SearchOptions.parse(multi_query_string) }

      describe "returns a collection" do
        it "that is enumerable" do
          [single_element, multi_element].each do |it|
            expect(it).to respond_to(:each)
          end
        end

        describe "whose contents" do
          it "have search_type that are symbols" do
            expect(single_element.collect(&:search_type)).to eq([:test])
            expect(multi_element.collect(&:search_type)).to eq([:test, :test2])
          end

          it "have search_param that are strings" do
            expect(single_element.collect(&:search_param)).to eq(["filter"])
            expect(multi_element.collect(&:search_param)).to eq(%w(filter filter2))
          end
        end
      end
    end

    describe "with a nil" do
      let(:nil_element) { SearchOptions.parse(nil) }
      describe "returns a collection" do
        it "that is enumerable" do
          expect(nil_element).to respond_to(:each)
        end

        it "with one element" do
          expect(nil_element.count).to eq(1)
        end

        it "with nil search_type" do
          expect(nil_element.first.search_type).to be_nil
        end

        it "with nil search_param" do
          expect(nil_element.first.search_param).to be_nil
        end
      end
    end
  end
end