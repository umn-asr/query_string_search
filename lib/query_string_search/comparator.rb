module QueryStringSearch
  module Comparator
    def self.does(subject)
      Comparison.new(subject)
    end

    class Comparison
      attr_accessor :subject

      def initialize(subject)
        self.subject = subject
      end

      def equal?(other)
        normalize(subject) == normalize(other)
      end

      def normalize(unnormalized)
        if unnormalized.respond_to?(:each)
          unnormalized.map(&:to_s).map(&:upcase)
        else
          unnormalized.to_s.upcase
        end
      end

      def contain?(other)
        normalize(subject).include?(normalize(other))
      end
    end
  end
end
