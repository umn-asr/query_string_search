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

  def self.build_me?(_, search_param)
    reserved_words.any? { |r| r.match(search_param) }
  end
end
