module Comparator
  def self.does(target)
    Comparison.new(target)
  end

  class Comparison
    attr_accessor :target

    def initialize(target)
      self.target = target
    end

    def equal?(other)
      target.to_s.upcase == other.to_s.upcase
    end

    def contain?(other)
      target.map(&:to_s).map(&:upcase).include?(other.to_s.upcase)
    end
  end
end
