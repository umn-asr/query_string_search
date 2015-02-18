module Comparator
  def self.does(desired)
    Comparison.new(desired)
  end

  class Comparison
    attr_accessor :desired

    def initialize(desired)
      self.desired = desired
    end

    def equal?(other)
      desired.to_s.upcase == other.to_s.upcase
    end

    def contain?(other)
      desired.map(&:to_s).map(&:upcase).include?(other.to_s.upcase)
    end
  end
end
