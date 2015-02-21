module QueryStringSearch
  module Comparator
    class ComparisonFactory
      def self.build(config, available_comparisons = AbstractComparison.comparisons)
        comparison_to_build = available_comparisons.detect { |c| c.build_me?(config) }

        if comparison_to_build
          comparison = comparison_to_build.new
          comparison.subject = config.subject
          comparison.other = config.other
          comparison.operator = config.operator.to_sym
          comparison
        end
      end
    end
  end
end
