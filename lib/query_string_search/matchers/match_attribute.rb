class MatchAttribute < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency { actual_value(data) }
  end

  def self.reserved_words
    [
      /^true$/,
      /^all$/
    ]
  end

  def self.build_me?(search_option)
    reserved_words.any? { |r| r.match(search_option.search_param) }
  end
end
