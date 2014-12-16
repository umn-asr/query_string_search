class MatchNoAttribute < AbstractMatcher
  def match?(target)
    target.public_send(attribute).nil?
  end

  def self.reserved_words
    %w(false none)
  end

  def self.build_me?(_, search_param)
    reserved_words.include?(search_param)
  end
end
