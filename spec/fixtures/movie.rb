class Movie
  attr_accessor :title, :rating, :year, :country, :seen, :star_rating, :home_formats

  def self.random_collection(count = 100)
    (1...count).map { |_| Movie.random }
  end

  def self.random
    Movie.new
  end

  def initialize
    self.title       = random_title
    self.rating      = random_rating
    self.year        = random_year
    self.country     = random_country
    self.seen        = [true, false].sample
    self.star_rating = [1, 2, 3, 4, 5].sample
    self.home_formats = %w(BD DVD Hulu Amazon Netflix).sample(2)
  end

  def seen?
    seen
  end

  def random_title
    "Random Movie #{rand(10_000)}"
  end

  def random_rating
    ["X", "NC-17", "R", "PG-13", "PG", "G", nil].sample
  end

  def random_year
    (1990..2014).to_a.sample.to_s
  end

  def random_country
    %w(
      US CAN UK HK BR RUS FR IN
    ).sample
  end
end
