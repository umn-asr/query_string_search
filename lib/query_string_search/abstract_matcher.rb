module QueryStringSearch
  class AbstractMatcher
    attr_accessor :attribute, :desired_value

    def self.matchers
      descendants.push(self)
    end

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < AbstractMatcher }
    end

    def self.all_reserved_words
      descendants.each_with_object([]) { |d, ret| ret << d.reserved_words }.flatten
    end

    def match?(_)
      false
    end

    def self.reserved_words
      []
    end

    def self.build_me?(_)
      true
    end

    private

    def match_with_contingency
      yield
    rescue
      false
    end

    def actual_value(actual)
      actual.public_send(attribute)
    end
  end
end
Dir.glob(File.join(File.dirname(__FILE__), "matchers", "*.rb")) { |file| require file }
