class MatchNoAttribute < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency { !target.public_send(attribute) }
  end

  def self.reserved_words
    %w(false none)
  end

  def self.build_me?(_, search_param)
    reserved_words.include?(search_param)
  end
end
