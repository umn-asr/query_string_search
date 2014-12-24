class MatchAttribute < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency { !target.public_send(attribute).nil? }
  end

  def self.reserved_words
    %w(true all)
  end

  def self.build_me?(_, search_param)
    reserved_words.include?(search_param)
  end
end
