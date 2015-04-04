class MatchNoAttribute < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency do
      actual_value(data) == false ||
        Array(actual_value(data)).empty?
    end
  end

  def self.reserved_words
    [
      /^false$/,
      /^none$/
    ]
  end

  def self.build_me?(search_option)
    reserved_words.any? { |r| r.match(search_option.desired_value) }
  end
end
