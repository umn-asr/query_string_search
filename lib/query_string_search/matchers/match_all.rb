class MatchAll < QueryStringSearch::AbstractMatcher
  def match?(_)
    true
  end

  def self.build_me?(search_option)
    search_option.search_type.nil? && search_option.search_param.nil?
  end
end
