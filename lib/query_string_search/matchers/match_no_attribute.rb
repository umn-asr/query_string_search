class MatchNoAttribute < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency { !target.public_send(attribute) }
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
