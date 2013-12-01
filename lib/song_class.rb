
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
    genre_array = Genre.all.select { |x| x.name == new_genre }
    if genre_array.size == 0
      g_obj = Genre.new.tap{|g| g.name = new_genre}
    else
      g_obj = genre_array[0]
    end
    @genre = g_obj
    g_obj.songs << self
  end

  def self.all
    SONGS
  end

end



  # def genre=(new_genre)
  #   new_genre = Genre.new.tap{|g| g.name = new_genre} unless new_genre.class == Genre
  #   @genre = new_genre
  #   new_genre.songs << self
  # end