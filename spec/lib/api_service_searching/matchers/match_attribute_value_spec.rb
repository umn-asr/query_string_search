require_relative "../../../../lib/api_service_searching/abstract_matcher"

Target = Struct.new(:search_attr)

RSpec.describe MatchAttributeValue do
  describe "match?" do
    describe "given a target with an attribute that matches the Parameter's attribute" do
      let(:target) { Target.new("search_value") }
      let(:value) { "search_value" }
      let(:subject) { MatchAttributeValue.new(:search_attr, value) }

      it "returns true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "given a value with spaces" do
      let(:target) { Target.new("search value") }
      let(:value) { "search value" }
      let(:subject) { MatchAttributeValue.new(:search_attr, value) }

      it "returns true" do
        expect(subject.match?(target)).to be_truthy
      end
    end

    describe "given a target with an attribute that does not match the Parameter's attribute" do
      let(:target) { Target.new("other_value") }
      let(:value) { "search_value" }
      let(:subject) { MatchAttributeValue.new(:search_attr, value) }

      it "returns false" do
        expect(subject.match?(target)).to be_falsey
      end
    end

    describe "if the target doesn't have the attribute" do
      let(:value) { "search_value" }
      let(:target) { Target.new(value) }
      let(:subject) { MatchAttribute.new(:bad_attr, value) }

      it "is false" do
        expect(subject.match?(target)).to be_falsey
      end
    end
  end

  describe "build_me?" do
    describe "given a non-nil search_type and search_param" do
      it "is true" do
        expect(MatchAttributeValue.build_me?(rand, rand)).to be_truthy
      end
    end

    describe "given a nil search_type or search_param" do
      it "is false" do
        expect(MatchAttributeValue.build_me?(rand, nil)).to be_falsey
        expect(MatchAttributeValue.build_me?(nil, rand)).to be_falsey
        expect(MatchAttributeValue.build_me?(nil, nil)).to be_falsey
      end
    end
  end
end
