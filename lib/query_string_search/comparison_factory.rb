module QueryStringSearch
  class ComparisonFactory
    def self.build(matcher, available_comparisons = AbstractComparison.comparisons)
      comparison_to_build = available_comparisons.detect { |c| c.build_me?(matcher) }

      if comparison_to_build
        comparison = comparison_to_build.new
        comparison.subject = matcher.desired_value
        comparison.operator = matcher.operator
        comparison
      end
    end
  end
end
