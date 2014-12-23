class MatchAll < AbstractMatcher
  def match?(_)
    true
  end

  def self.build_me?(search_type, search_param)
    search_type.nil? && search_param.nil?
  end
end
