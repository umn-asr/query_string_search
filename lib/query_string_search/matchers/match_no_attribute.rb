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

  def self.build_me?(search_option)
    reserved_words.any? { |r| r.match(search_option.search_param) }
  end
end
