class MatchAll < QueryStringSearch::AbstractMatcher
  def match?(_)
    true
  end

  def self.build_me?(search_option)
    search_option.attribute.nil? && search_option.desired_value.nil?
  end
end
