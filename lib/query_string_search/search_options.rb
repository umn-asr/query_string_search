module QueryStringSearch
  module SearchOptions
    def self.parse(query_string)
      if query_string
        search_params = query_string.split(",")
        search_params.each_with_object([]) do |p, ret|
          ret << QueryStringSearch::SearchOption.new(p)
        end
      else
        [QueryStringSearch::SearchOption.new(nil)]
      end
    end
  end
end
