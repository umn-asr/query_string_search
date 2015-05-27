require "delegate"

module QueryStringSearch
  class AbstractComparison
    attr_accessor :other, :subject, :operator

    def self.comparisons
      descendants.push(self)
    end

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < AbstractComparison }
    end

    def self.all_reserved_operators
      descendants.each_with_object([]) { |d, ret| ret << d.reserved_operators }.flatten
    end

    def self.reserved_operators
      []
    end

    def normalize(unnormalized)
      Array(unnormalized).map(&:to_s).map(&:upcase)
    end

    def compare
      false
    end

    def self.build_me?(_)
      true
    end
  end
end
Dir.glob(File.join(File.dirname(__FILE__), "comparisons", "*.rb")) { |file| require file }
