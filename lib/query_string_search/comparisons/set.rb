module QueryStringSearch
  module Comparator
    class Set < AbstractComparison
      def compare(other)
        (normalize(subject) & normalize(other)).any?
      end

      def self.build_me?(config)
        ![:<, :>, :<=, :>=].include?(config.operator.to_sym)
      end
    end
  end
end
