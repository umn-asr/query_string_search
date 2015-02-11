require_relative "../../../../lib/query_string_search/abstract_matcher"
require_relative "../../../doubles/search_target"

RSpec.describe MatchNoAttribute do
  describe "match?" do
    describe "if the target's attribute is not nil" do
      let(:target) { SearchTarget.new(search_attr: "search_value") }
      let(:subject) { MatchNoAttribute.new(:search_attr) }

      it "is false" do
        expect(subject.match?(target)).to be_falsey
      end
    end

    describe "if the target's attribute is true" do
      let(:target) { SearchTarget.new(search_attr: true) }
      let(:subject) { MatchNoAttribute.new(:search_attr) }

      it "is true" do
        expect(subject.match?(target)).to be_falsey
      end
    end

    describe "if the target's attribute is false" do
      let(:target) { SearchTarget.new(search_attr: false) }
      let(:subject) { MatchNoAttribute.new(:search_attr) }

      it "is true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "if the target's attribute is nil" do
      let(:target) { SearchTarget.new(search_attr: nil) }
      let(:subject) { MatchNoAttribute.new(:search_attr) }

      it "is true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "if the target doesn't have the attribute" do
      let(:target) { SearchTarget.new(search_attr: rand) }
      let(:subject) { MatchNoAttribute.new(:bad_attr) }

      it "is false" do
        expect(subject.match?(target)).to be_falsey
      end
    end
  end

  describe "build_me?" do
    describe "given a search param of 'none' or 'false'" do
      it "is true" do
        %w(none false).each do |search_param|
          expect(MatchNoAttribute.build_me?(rand, search_param)).to be_truthy
        end
      end
    end

    describe "given a search param that is not 'none' or 'false'" do
      it "is false" do
        %w(one falsey).each do |search_param|
          expect(MatchNoAttribute.build_me?(rand, search_param)).to be_falsey
        end
      end
    end
  end
end
