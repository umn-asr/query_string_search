module QueryStringSearch
  module Comparator
    class Set < AbstractComparison
      def compare(other)
        (Array(normalize(subject)) & Array(normalize(other))).any?
      end

      def self.build_me?(config)
        config.subject.respond_to?(:each) || config.other.respond_to?(:each)
      end
    end
  end
end
