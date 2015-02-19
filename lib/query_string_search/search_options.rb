module QueryStringSearch
  class SearchOptions
    attr_reader :search_type, :search_param, :operator

    def self.parse(query_string)
      if query_string
        search_params = query_string.split(",")
        search_params.each_with_object([]) do |p, ret|
          ret << new(p)
        end
      else
        [new(nil)]
      end
    end

    def initialize(raw_query)
      parsed_query = /(?<attribute>\w+)(?<operator>\W+)(?<value>.+)/.match(raw_query)
      if parsed_query
        self.search_type  = parsed_query[:attribute]
        self.search_param = parsed_query[:value]
        self.operator     = parsed_query[:operator]
      end
    end

    def search_type
      @search_type ? @search_type.to_sym : nil
    end

    private

    attr_writer :search_type, :search_param, :operator
  end
end
