
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

  def page
    es = "s"
    es = "" if self.songs.size == 1
    puts "#{self.name} - #{self.songs.size} Song#{es}"
    self.songs.each_with_index do |s_obj, i|
      puts "  #{i+1}.#{s_obj.name} - #{s_obj.genre.name}"
    end
  end

  def menu
    es = "s"
    es = "" if art_obj.songs.size == 1
    puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
  end

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
