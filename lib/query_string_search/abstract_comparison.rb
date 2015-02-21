module QueryStringSearch
  module Comparator
    class AbstractComparison
      attr_accessor :other, :subject, :operator

      def self.comparisons
        descendants.push(self)
      end

      def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < AbstractComparison }
      end

      def normalize(unnormalized)
        if unnormalized.respond_to?(:each)
          unnormalized.map(&:to_s).map(&:upcase)
        else
          unnormalized.to_s.upcase
        end
      end

      def compare
        false
      end

      def self.build_me?(_)
        true
      end
    end
  end
end
Dir.glob(File.join(File.dirname(__FILE__), "comparisons", "*.rb")) { |file| require file }
