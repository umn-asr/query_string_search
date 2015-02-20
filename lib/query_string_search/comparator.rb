module QueryStringSearch
  module Comparator
    def self.using(operator)
      create_comparison
      comparison.operator = operator
      self
    end

    def self.does(subject)
      create_comparison
      comparison.subject = subject
      self
    end

    def self.equal?(other)
      comparison.operator = "="
      compare_with?(other)
    end

    def self.contain?(other)
      comparison.operator = "∈"
      compare_with?(other)
    end

    def self.compare_with?(other)
      comparison.other = other
      resolve
    end

    private

    def self.create_comparison
      @comparison ||= Comparison.new
    end

    def self.comparison
      @comparison
    end

    def self.resolve
      ret = @comparison.compare
      @comparison = nil
      ret
    end
  end
end

module QueryStringSearch
  module Comparator
    class Comparison
      attr_accessor :subject, :operator, :other

      def compare
        if ["=".to_sym].include?(operator)
          equal?
        elsif [:∈].include?(operator)
          contain?
        elsif [:<, :>, :<=, :>=].include?(operator)
          inequal?
        else
          false
        end
      end

      def operator=(x)
        @operator = x.to_sym
      end

      def inequal?
        other.to_i.public_send(operator, subject.to_i)
      end

      def equal?
        normalize(other).public_send(:==, normalize(subject))
      end

      def contain?
        normalize(subject).public_send(:&, [normalize(other)]).any?
      end

      def normalize(unnormalized)
        if unnormalized.respond_to?(:each)
          unnormalized.map(&:to_s).map(&:upcase)
        else
          unnormalized.to_s.upcase
        end
      end
    end
  end
end
