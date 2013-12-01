
class Genre
  attr_accessor :name
  attr_reader :songs, :artists
  GENRES = []

  def initialize
    @name = ""
    @songs = []
    @artists = []
    GENRES << self
  end
 
  def self.reset_genres
    GENRES.clear
  end

  def self.all
    GENRES
  end


end