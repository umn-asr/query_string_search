class MatchMultipleAttributeValues < QueryStringSearch::AbstractMatcher
  def match?(target)
    match_with_contingency do
      value.include?(target.public_send(attribute).to_s.upcase)
    end
  end

  def self.reserved_words
    [
      /^\w+\|\w+/
    ]
  end

  def value=(x)
    super(x.split("|").map {|a| a.upcase})
  end

  def self.build_me?(_, search_param)
    reserved_words.any? { |r| r.match(search_param) }
  end
end
