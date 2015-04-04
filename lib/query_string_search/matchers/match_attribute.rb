class MatchAttribute < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency do
      actual_value(data) == true ||
        Array(actual_value(data)).any?
    end
  end

  def self.reserved_words
    [
      /^true$/,
      /^all$/
    ]
  end

  def self.build_me?(search_option)
    reserved_words.any? { |r| r.match(search_option.desired_value) }
  end
end
