class AbstractMatcher
  attr_accessor :attribute, :value

  def self.matchers
    descendants.push(self)
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < AbstractMatcher }
  end

  def self.all_reserved_words
    descendants.each_with_object([]) { |d, ret| ret << d.reserved_words }.flatten
  end

  def initialize(attribute = nil, value = nil)
    self.attribute = attribute
    self.value = value
  end

  def all?
    false
  end

  def match?(_)
    false
  end

  def self.reserved_words
    []
  end

  def self.build_me?(_, _)
    true
  end
end

Dir.glob(File.join(File.dirname(__FILE__), "matchers", "*.rb")) { |file| require file }
