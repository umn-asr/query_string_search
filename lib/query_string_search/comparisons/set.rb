module QueryStringSearch
  class SetComparison < AbstractComparison
    def compare(other)
      (normalize(subject) & normalize(other)).send(operator)
    end

    def operator=(x)
      if x == :!=
        super(:none?)
      else
        super(:any?)
      end
    end

    def self.build_me?(matcher)
      all_reserved_operators.none? { |o| o == matcher.operator }
    end
  end
end
