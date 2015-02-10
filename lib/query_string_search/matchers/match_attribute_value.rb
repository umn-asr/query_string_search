class MatchAttributeValue < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency do
      target.public_send(attribute).to_s.upcase == value.to_s.upcase
    end
  end

  def self.build_me?(search_type, search_param)
    search_param &&
      search_type &&
      all_reserved_words.none? { |r| r.match(search_param) }
  end
end
