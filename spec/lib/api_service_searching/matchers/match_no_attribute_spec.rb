require "ostruct"
require_relative "../../../../lib/api_service_searching/abstract_matcher"

RSpec.describe MatchNoAttribute do
  describe "all?" do
    it "is false" do
      expect(subject.all?).to be_falsey
    end
  end

  describe "match?" do
    describe "if the target's attribute is not nil" do
      let(:target) { OpenStruct.new(search_attr: "search_value") }
      let(:value) { "search_value" }
      let(:subject) { MatchNoAttribute.new(:search_attr, value) }

      it "is false" do
        expect(subject.match?(target)).to be_falsey
      end
    end

    describe "if the target's attribute is nil" do
      let(:target) { OpenStruct.new(search_attr: nil) }
      let(:value) { nil }
      let(:subject) { MatchNoAttribute.new(:search_attr, value) }

      it "is true" do
        expect(subject.match?(target)).to be_truthy
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
