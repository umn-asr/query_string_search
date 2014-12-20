require "ostruct"
require_relative "../../../../lib/api_service_searching/abstract_matcher"

RSpec.describe MatchAttribute do
  describe "all?" do
    it "is false" do
      expect(subject.all?).to be_falsey
    end
  end

  describe "match?" do
    describe "if the target's attribute is not nil" do
      let(:target) { OpenStruct.new(search_attr: "search_value") }
      let(:value) { "search_value" }
      let(:subject) { MatchAttribute.new(:search_attr, value) }

      it "is true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "if the target's attribute is nil" do
      let(:target) { OpenStruct.new(search_attr: nil) }
      let(:value) { nil }
      let(:subject) { MatchAttribute.new(:search_attr, value) }

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
