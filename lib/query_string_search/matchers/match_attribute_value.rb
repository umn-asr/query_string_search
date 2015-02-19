class MatchAttributeValue < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency do
      Comparator.does(desired_value).equal?(actual_value(data))
    end
  end

  def self.build_me?(search_option)
    search_option.search_param &&
      search_option.search_type &&
      all_reserved_words.none? { |r| r.match(search_option.search_param) }
  end
end
