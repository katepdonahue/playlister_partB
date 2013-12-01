
class Artist
  attr_accessor :name, :songs
  attr_reader :count, :genres
  ARTISTS = []

  def initialize
    @name = ""
    @songs = []
    @genres = []
    ARTISTS << self
  end

  def self.all
    ARTISTS
  end

  def self.reset_artists
    ARTISTS.clear
  end
 
  def self.count
    ARTISTS.size
  end

  def songs_count
    songs.size
  end

  def add_song(song)
    songs << song
    genres << song.genre # if (song.genre != "") && ((genres.include? song.genre) == false)
    song.artist = self
    Genre::GENRES.each do |genre_obj|
      if genre_obj.name == song.genre.name && ((genre_obj.artists.include? self) == false)
        genre_obj.artists << self
      end
    end
  end

  # def add_song(song)
  #   songs << song
  #   if song.genre != ""
  #     genres << song.genre
  #     #debugger
  #     # song.genre ||= Genre.new.tap{|g| g.name = song.genre}
  #     song.genre.artists << self if song.genre.artists.include? self == false
  #   end
  # end


  # def genres=(new_genre)
  #   genres << new_genre
  #   new_genre ||= Genre.new .tap{|g| g.name = new_genre}
  #   new_genre.artists << self
  # end

end


  # it 'A genre has many artists' do
  #   genre = Genre.new.tap{|g| g.name = 'rap'}

  #   [1,2].each do
  #     artist = Artist.new             # make sure genre's array of artists contains these
  #     song = Song.new                 # When does an artist get a genre?
  #     song.genre = genre              # When it gets a song which has a genre.
  #     artist.add_song(song)           # So basically, this happens in the add_song method
  #   end                               # so add song.genre ('rap') to this artists genres in add_song
  #                                     # and add this artist to the genre object's artists array
  #   genre.artists.count.should eq(2) 
  # end

  #   it 'A genres Artists are unique' do
  #   genre = Genre.new.tap{|g| g.name = 'rap'}
  #   artist = Artist.new

  #   [1,2].each do
  #     song = Song.new
  #     song.genre = genre
  #     artist.add_song(song)
  #   end

  #   genre.artists.count.should eq(1)
  # end
