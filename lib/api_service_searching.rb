module ApiServiceSearching
  def self.where(data_source, query_string)
    SearchParameters.build_from_querystring(query_string).each do |param|
      data_source = filter_by_param(data_source, param)
    end
    data_source
  end

  def self.filter_by_param(data_source, param)
    data_source.select { |c| param.match?(c) }
  end
end

Dir.glob(File.join(File.dirname(__FILE__), "api_service_searching", "*.rb")) { |file| require file }
