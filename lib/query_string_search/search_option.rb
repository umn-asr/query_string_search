module QueryStringSearch
  class SearchOption
    attr_reader :search_type, :search_param, :operator

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
