module QueryStringSearch
  module Comparator
    class Inequality < AbstractComparison
      def compare(other)
        other.to_i.public_send(operator, subject.to_i)
      end

      def self.build_me?(config)
        [:<, :>, :<=, :>=].include?(config.operator.to_sym)
      end
    end
  end
end
