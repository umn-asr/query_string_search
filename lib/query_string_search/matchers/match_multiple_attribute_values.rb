class MatchMultipleAttributeValues < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency do
      Comparator.does(value).contain?(target.public_send(attribute))
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
