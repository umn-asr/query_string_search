module QueryStringSearch
  class InequalityComparison < AbstractComparison
    def compare(other)
      normalize(other).public_send(operator, normalize(subject))
    end

    def normalize(unnormalized)
      unnormalized.to_f
    end

    def self.reserved_operators
      [:<, :>, :<=, :>=]
    end

    def self.build_me?(matcher)
      reserved_operators.include?(matcher.operator)
    end
  end
end
