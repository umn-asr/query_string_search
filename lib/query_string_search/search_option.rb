module QueryStringSearch
  class SearchOption
    attr_reader :attribute, :desired_value, :operator

    def initialize(raw_query)
      parsed_query       = KeyValue.parse(raw_query)
      self.attribute     = parsed_query.attribute
      self.desired_value = parsed_query.desired_value
      self.operator      = parsed_query.operator
    end

    def attribute
      @attribute ? @attribute.to_sym : nil
    end

    private

    attr_writer :attribute, :desired_value, :operator
  end

  class KeyValue
    attr_accessor :attribute, :desired_value, :operator

    def self.parse(raw_query)
      new(/(?<attribute>\w+)(?<operator>\W+)(?<desired_value>.+)/.match(raw_query))
    end

    def initialize(match_data)
      match_data         = match_data ? match_data : {}
      self.attribute     = match_data[:attribute]
      self.desired_value = match_data[:desired_value]
      self.operator      = match_data[:operator]
    end
  end
end
