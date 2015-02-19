class MatchNoAttribute < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency { !actual_value(data) }
  end

  def self.reserved_words
    [
      /^false$/,
      /^none$/
    ]
  end

  def self.build_me?(_, search_param)
    reserved_words.any? { |r| r.match(search_param) }
  end
end
