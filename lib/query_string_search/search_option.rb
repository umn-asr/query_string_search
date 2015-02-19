module QueryStringSearch
  class SearchOption
    attr_reader :attribute, :desired_value, :operator

    def initialize(raw_query)
      parsed_query = /(?<attribute>\w+)(?<operator>\W+)(?<value>.+)/.match(raw_query)
      if parsed_query
        self.attribute     = parsed_query[:attribute]
        self.desired_value = parsed_query[:value]
        self.operator      = parsed_query[:operator]
      end
    end

    def attribute
      @attribute ? @attribute.to_sym : nil
    end

    private

    attr_writer :attribute, :desired_value, :operator
  end
end
