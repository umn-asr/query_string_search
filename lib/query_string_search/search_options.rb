module QueryStringSearch
  module SearchOptions
    def self.parse(query_string)
      if query_string
        query_string.split(",").each_with_object([]) do |p, ret|
          ret << QueryStringSearch::SearchOption.new(p)
        end
      else
        [QueryStringSearch::SearchOption.new(nil)]
      end
    end
  end
end
