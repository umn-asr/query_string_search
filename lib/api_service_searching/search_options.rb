class SearchOptions
  attr_reader :search_type, :search_param

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
    self.search_type, self.search_param = raw_query.to_s.split("=")
  end

  def search_type
    @search_type ? @search_type.to_sym : nil
  end

  def search_param
    @search_param ? CGI.unescape(@search_param) : @search_param
  end

  private

  attr_writer :search_type, :search_param
end
