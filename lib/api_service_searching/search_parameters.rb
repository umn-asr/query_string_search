class SearchParameters
  extend Forwardable

  def_delegators :@collection, :each_with_object

  def self.build_from_querystring(query_string, factory = MatcherFactory, matchers = AbstractMatcher.matchers)
    parameters = SearchOptions.parse(query_string)
    new(parameters, factory, matchers)
  end

  def initialize(parameters, factory, matchers)
    parameters.each do |param|
      collection << factory.build(param, matchers)
    end
  end

  def collection
    @collection ||= []
  end
end
