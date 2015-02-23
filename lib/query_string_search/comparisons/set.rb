module QueryStringSearch
  module Comparator
    class Set < AbstractComparison
      def compare(other)
        (normalize(subject) & normalize(other)).any?
      end

      def self.build_me?(matcher)
        all_reserved_operators.none? { |o| o == matcher.operator }
      end
    end
  end
end
