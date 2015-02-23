module QueryStringSearch
  def self.new(data_source, query_string)
    QueryStringSearch::Search.new(data_source, query_string)
  end

  class Search
    attr_accessor :data_source
    attr_reader :query_string

    def initialize(data_source, query_string)
      self.data_source = data_source
      self.query_string = query_string
    end

    def results
      @results = data_source
      QueryStringSearch::SearchParameters.build_from_querystring(query_string).each do |param|
        @results = filter_by_param(@results, param)
      end
      @results
    end

    private

    def query_string=(x)
      @query_string = x ? CGI.unescape(x) : nil
    end

    def filter_by_param(data, param)
      data.select { |c| param.match?(c) }
    end
  end
end

Dir.glob(File.join(File.dirname(__FILE__), "query_string_search", "*.rb")) { |file| require file }
