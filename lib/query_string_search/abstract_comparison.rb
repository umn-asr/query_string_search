require "delegate"

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

    class Comparison < SimpleDelegator
      def compare(data)
        concrete_comparison = get_concrete_comparison(data)
        swap_compare_methods(concrete_comparison)
        concrete_comparison.compare(data)
      end

      def get_concrete_comparison(data)
        config = OpenStruct.new
        config.subject = desired_value
        config.other = data
        config.operator = operator
        ComparisonFactory.build(config)
      end

      def swap_compare_methods(concrete_comparison)
        instance_eval "undef :compare"
        __setobj__(concrete_comparison)
      end
    end
  end
end
Dir.glob(File.join(File.dirname(__FILE__), "comparisons", "*.rb")) { |file| require file }
