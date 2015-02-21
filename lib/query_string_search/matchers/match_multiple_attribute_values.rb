class MatchMultipleAttributeValues < QueryStringSearch::AbstractMatcher
  def match?(data)
    match_with_contingency do
      create_comparison(data)
      comparison.other = actual_value(data)
      comparison.compare
      #QueryStringSearch::Comparator.does(desired_value).contain?(actual_value(data))
    end
  end

  def operator
    :&
  end

  def self.reserved_words
    [
      /^\w+\|\w+/
    ]
  end

  def desired_value=(x)
    super(x.split("|"))
  end

  def self.build_me?(search_option)
    reserved_words.any? { |r| r.match(search_option.desired_value) }
  end
end
