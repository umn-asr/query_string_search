class MatchAttributeValue < AbstractMatcher
  def match?(target)
    target.public_send(attribute).to_s.upcase == value.to_s.upcase
  end

  def self.build_me?(search_type, search_param)
    search_param && search_type && !all_reserved_words.include?(search_param)
  end
end
