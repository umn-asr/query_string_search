require_relative "../../../../lib/query_string_search/abstract_matcher"
require_relative "../../../doubles/search_target"

RSpec.describe MatchAttribute do
  describe "match?" do
    describe "if the target's attribute is not nil" do
      let(:target) { Target.new("search_value") }
      let(:subject) { MatchAttribute.new(:search_attr) }

      it "is true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "if the target's attribute is true" do
      let(:target) { Target.new(true) }
      let(:subject) { MatchAttribute.new(:search_attr) }

      it "is true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "if the target's attribute is nil" do
      let(:target) { Target.new(nil) }
      let(:subject) { MatchAttribute.new(:search_attr) }

      it "is false" do
        expect(subject.match?(target)).to be_falsey
      end
    end

    describe "if the target's attribute is false" do
      let(:target) { Target.new(false) }
      let(:subject) { MatchAttribute.new(:search_attr) }

      it "is true" do
        expect(subject.match?(target)).to be_falsey
      end
    end

    describe "if the target doesn't have the attribute" do
      let(:target) { Target.new(rand) }
      let(:subject) { MatchAttribute.new(:bad_attr) }

      it "is false" do
        expect(subject.match?(target)).to be_falsey
      end
    end
  end

  describe "build_me?" do
    describe "given a search param of 'all' or 'true'" do
      it "is true" do
        %w(all true).each do |search_param|
          expect(MatchAttribute.build_me?(rand, search_param)).to be_truthy
        end
      end
    end

    describe "given a search param that is not 'all' or 'true'" do
      it "is false" do
        %w(1all rue).each do |search_param|
          expect(MatchAttribute.build_me?(rand, search_param)).to be_falsey
        end
      end
    end
  end
end
