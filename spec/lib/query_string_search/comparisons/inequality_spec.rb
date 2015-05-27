require_relative "../../../../lib/query_string_search/abstract_comparison"

RSpec.describe QueryStringSearch::InequalityComparison do
  describe "reserved_operators" do
    it "reserves the equality comparison operators" do
      expect([:<, :>, :<=, :>=]).to eq(QueryStringSearch::InequalityComparison.reserved_operators)
    end
  end

  describe "build_me?" do
    let(:matcher) { instance_double(QueryStringSearch::AbstractMatcher) }
    it "is true if the matcher's operator is one of the Inequality reserved_operators" do
      QueryStringSearch::InequalityComparison.reserved_operators.each do |o|
        allow(matcher).to receive(:operator).and_return(o)
        expect(QueryStringSearch::InequalityComparison.build_me?(matcher)).to be_truthy
      end
    end

    it "is false if the matcher's operator is not one of the reserved operators" do
      allow(matcher).to receive(:operator).and_return(:inspect)
      expect(QueryStringSearch::InequalityComparison.build_me?(matcher)).to be_falsey
    end
  end

  describe "compare" do
    describe "using less than" do
      let(:comparison) do
        comparison = QueryStringSearch::InequalityComparison.new
        comparison.subject = 1.0
        comparison.operator = :<
        comparison
      end

      it "is true if the compared value is less than the subject" do
        expect(comparison.compare(0.9)).to be_truthy
      end

      it "is false if the compared value is equal to the subject" do
        expect(comparison.compare(1)).to be_falsey
      end

      it "is false if the compared value is greater than the subject" do
        expect(comparison.compare(1.1)).to be_falsey
      end

      it "works if the values are strings" do
        comparison.subject = "1.05"
        expect(comparison.compare("1")).to be_truthy
      end
    end
  end

  describe "using less-than-or-equal-to" do
    let(:comparison) do
      comparison = QueryStringSearch::InequalityComparison.new
      comparison.subject = 1.0
      comparison.operator = :<=
      comparison
    end

    it "is true if the compared value is less than the subject" do
      expect(comparison.compare(0.9)).to be_truthy
    end

    it "is true if the compared value is equal to the subject" do
      expect(comparison.compare(1)).to be_truthy
    end

    it "is false if the compared value is greater than the subject" do
      expect(comparison.compare(1.1)).to be_falsey
    end

    it "works if the values are strings" do
      comparison.subject = "1.0"
      expect(comparison.compare("1")).to be_truthy
    end
  end

  describe "greater than" do
    let(:comparison) do
      comparison = QueryStringSearch::InequalityComparison.new
      comparison.subject = 1.0
      comparison.operator = :>
      comparison
    end

    it "is false if the compared value is less than the subject" do
      expect(comparison.compare(0.9)).to be_falsey
    end

    it "is false if the compared value is equal to the subject" do
      expect(comparison.compare(1)).to be_falsey
    end

    it "is true if the compared value is greater than the subject" do
      expect(comparison.compare(1.1)).to be_truthy
    end

    it "works if the values are strings" do
      comparison.subject = "1.0"
      expect(comparison.compare("1.1")).to be_truthy
    end
  end

  describe "greater-than-or-equal-to" do
    let(:comparison) do
      comparison = QueryStringSearch::InequalityComparison.new
      comparison.subject = 1.0
      comparison.operator = :>=
      comparison
    end

    it "is false if the compared value is less than the subject" do
      expect(comparison.compare(0.9)).to be_falsey
    end

    it "is true if the compared value is equal to the subject" do
      expect(comparison.compare(1)).to be_truthy
    end

    it "is true if the compared value is greater than the subject" do
      expect(comparison.compare(1.1)).to be_truthy
    end

    it "works if the values are strings" do
      comparison.subject = "1.0"
      expect(comparison.compare("1")).to be_truthy
    end
  end
end
