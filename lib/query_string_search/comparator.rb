module QueryStringSearch
  module Comparator
    def self.using(operator)
      config.operator = operator.to_sym
      self
    end

    def self.does(subject)
      config.subject = subject
      self
    end

    def self.equal?(other)
      config.operator = :==
      compare_with?(other)
    end

    def self.contain?(other)
      config.operator = :&
      compare_with?(other)
    end

    def self.compare_with?(other)
      config.other = other
      resolve
    end

    private

    def self.config
      @config ||= OpenStruct.new
    end

    def self.resolve
      ret = ComparisonFactory.build(config).compare
      @config = nil
      ret
    end
  end
end

module QueryStringSearch
  module Comparator
    class ComparisonFactory
      def self.build(config)
        if config.subject.respond_to?(:each)
          SetComparison.new(config.subject, config.other)
        elsif [:<, :>, :<=, :>=].include?(config.operator.to_sym)
          InequalityComparison.new(config.subject, config.other, config.operator)
        else
          EqualityComparison.new(config.subject, config.other)
        end
      end
    end

    class AbstractComparison
      attr_accessor :other, :subject, :operator

      def initialize(subject, other, operator = nil)
        self.subject = subject
        self.other = other
        self.operator = operator
      end

      def normalize(unnormalized)
        if unnormalized.respond_to?(:each)
          unnormalized.map(&:to_s).map(&:upcase)
        else
          unnormalized.to_s.upcase
        end
      end
    end

    class EqualityComparison < AbstractComparison
      def compare
        normalize(other) == normalize(subject)
      end
    end

    class SetComparison < AbstractComparison
      def compare
        (Array(normalize(subject)) & Array(normalize(other))).any?
      end
    end

    class InequalityComparison < AbstractComparison
      def compare
        other.to_i.public_send(operator, subject.to_i)
      end
    end
  end
end
