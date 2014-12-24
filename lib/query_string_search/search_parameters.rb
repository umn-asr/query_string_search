module QueryStringSearch
  class SearchParameters
    extend Forwardable

    def_delegators :@collection, :each

    def self.build_from_querystring(query_string, factory = QueryStringSearch::MatcherFactory, matchers = QueryStringSearch::AbstractMatcher.matchers)
      parameters = QueryStringSearch::SearchOptions.parse(query_string)
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
end
