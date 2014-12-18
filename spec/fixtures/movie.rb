class Movie
  attr_accessor :title, :rating, :year, :country

  def self.random_collection(count = 1_000)
    (1...count).inject([]) do |collection, id|
      collection << Movie.new(random_title, random_rating, random_year, random_country)
    end
  end

  def initialize(title, rating, year, country)
    self.title   = title
    self.rating  = rating
    self.year    = year
    self.country = country
  end

  def self.random_title
    "Random Movie #{rand(10_000)}"
  end

  def self.random_rating
    ["X", "NC-17", "R", "PG-13", "PG", "G", nil].sample
  end

  def self.random_year
    (1990..2014).to_a.sample.to_s
  end

  def self.random_country
    %w(
    US CAN UK HK BR RUS FR IN
    ).sample
  end
end
