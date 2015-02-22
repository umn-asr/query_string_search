module QueryStringSearch
  module Comparator
    class Equality < AbstractComparison
      def compare(other)
        normalize(other) == normalize(subject)
      end

      def self.build_me?(config)
        !config.subject.respond_to?(:each) &&
          !config.other.respond_to?(:each) &&
          ![:<, :>, :<=, :>=].include?(config.operator.to_sym)
      end
    end
  end
end
