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
