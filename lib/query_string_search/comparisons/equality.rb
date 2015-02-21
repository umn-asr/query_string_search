module QueryStringSearch
  module Comparator
    class Equality < AbstractComparison
      def compare
        normalize(other) == normalize(subject)
      end

      def self.build_me?(_)
        true
      end
    end
  end
end
