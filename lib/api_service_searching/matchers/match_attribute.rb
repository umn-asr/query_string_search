class MatchAttribute < AbstractMatcher
  def match?(target)
    !target.public_send(attribute).nil?
  rescue
    false
  end

  def self.reserved_words
    %w(true all)
  end

  def self.build_me?(_, search_param)
    reserved_words.include?(search_param)
  end
end
