
class Song
  attr_accessor :name, :artist
  attr_reader :genre
  SONGS = []

  def initialize
    @name = ""
    @artist = ""
    @genre = ""
    SONGS << self
  end

  def genre=(new_genre)
    new_genre = Genre.new .tap{|g| g.name = new_genre} unless new_genre.class == Genre
    @genre = new_genre
    new_genre.songs << self
  end

end