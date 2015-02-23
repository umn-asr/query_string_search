module QueryStringSearch
  class SearchParameters
    extend Forwardable

    def_delegators :@collection, :each

    def self.build_from_querystring(query_string, factory = QueryStringSearch::MatcherFactory, matchers = QueryStringSearch::AbstractMatcher.matchers)
      search_options = QueryStringSearch::SearchOptions.parse(query_string)
      new(search_options, factory, matchers)
    end

    def initialize(search_options, factory, matchers)
      search_options.each do |search_option|
        collection << factory.build(search_option, matchers)
      end
    end

    def collection
      @collection ||= []
    end
  end
end
