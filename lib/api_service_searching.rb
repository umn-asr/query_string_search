module ApiServiceSearching
  def self.where(data_source, query_string)
    search_parameters = SearchParameters.build_from_querystring(query_string)
    result_sets = search_parameters.each_with_object([]) do |param, ret|
      ret << (data_source.select { |c| param.match?(c) }).to_set
    end
    result_sets.inject(:intersection).to_a
  end
end

Dir.glob(File.join(File.dirname(__FILE__), "api_service_searching", "*.rb")) { |file| require file }
