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
      normalize(desired) == normalize(other)
    end

    def normalize(unnormalized)
      if unnormalized.respond_to?(:each)
        unnormalized.map(&:to_s).map(&:upcase)
      else
        unnormalized.to_s.upcase
      end
    end

    def contain?(other)
      normalize(desired).include?(normalize(other))
    end
  end
end
