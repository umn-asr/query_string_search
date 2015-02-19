class MatchAttributeValue < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency do
      Comparator.does(desired_value).equal?(actual_value(data))
    end
  end

  def self.build_me?(search_option)
    search_option.desired_value &&
      search_option.attribute &&
      all_reserved_words.none? { |r| r.match(search_option.desired_value) }
  end
end
