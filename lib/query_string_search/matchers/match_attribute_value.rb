class MatchAttributeValue < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency do
      create_comparison(data)
      comparison.other = actual_value(data)
      comparison.compare
      #QueryStringSearch::Comparator.using(operator).does(desired_value).compare_with?(actual_value(data))
    end
  end

  def self.build_me?(search_option)
    search_option.desired_value &&
      search_option.attribute &&
      all_reserved_words.none? { |r| r.match(search_option.desired_value) }
  end
end
