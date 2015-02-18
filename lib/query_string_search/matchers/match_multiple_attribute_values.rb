class MatchMultipleAttributeValues < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency do
      Comparator.does(value).contain?(target_value(target))
    end
  end

  def self.reserved_words
    [
      /^\w+\|\w+/
    ]
  end

  def value=(x)
    super(x.split("|"))
  end

  def self.build_me?(_, search_param)
    reserved_words.any? { |r| r.match(search_param) }
  end
end
