
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

  def page
    es = "s"
    es = "" if self.songs.size == 1
    puts "#{self.name} - #{self.songs.size} Song#{es}, #{self.artists.size} Artist#{es}"
    self.songs.each_with_index do |s_obj, i|
      puts "  #{i+1}.#{s_obj.artist.name} - #{s_obj.name}"
    end
  end

  def menu
    es = "" if self.songs.size == 1
    es = "s" if self.songs.size > 1
    puts "#{self.name} - #{self.songs.size} Song#{es}, #{self.artists.size} Artist#{es}" # the es on Artist is cheating
  end


end