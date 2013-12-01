require './lib/artist_class'
require './lib/genre_class'
require './lib/song_class'
require 'debugger'

def generate
  Dir["./data/*.mp3"].each do |file|
    # debugger
    artist_sg = file.split("/")[2].split(" - ")
    artist_array = Artist.all.select { |x| x.name == artist_sg[0] }
    if artist_array.size == 0
      new_artist = Artist.new.tap{ |a| a.name = artist_sg[0] } # need to check that artist doesn't already exist
    else
      new_artist = artist_array[0]
    end
    # debugger
    song_gen = artist_sg[1].gsub(" [", "].mp3").split("].mp3") # how do you do a split on multiple things?
    # debugger
    new_song = Song.new.tap{ |s| s.name = song_gen[0] }
    new_song.genre=(song_gen[1]) # makes genre an instance of genre class, add songs to songs array in genre class
    new_artist.add_song(new_song) # adds song object to new_artist.songs, adds genre to new_artists.genres, adds new_artist to genre_obj.artists
  end
end

def artist
  Artist.all.each do |art_obj|
    es = "s"
    es = "" if art_obj.songs.size == 1
    puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
  end
  artist_songs
end

def artist_songs(y = false)
  extra = "or song " if y
  puts "Type name of artist #{extra}for details"
  ans = gets.chomp
  done = false
  starts_with_array = []
  Artist.all.each do |art_obj|
    if (ans != art_obj.name) && (art_obj.name.start_with? ans)
      # es = "s"
      # es = "" if art_obj.songs.size == 1
      # if y
      #   puts "#{art_obj.genre.name} - #{art_obj.genre.songs.size} Song#{es}, #{art_obj.genre.artists.size} Artist#{es}"
      # else
      #   puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
      # end
      starts_with_array << art_obj
    elsif ans == art_obj.name 
      ans = art_obj
      # es = "s"
      # es = "" if art_obj.songs.size == 1
      # puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
      # art_obj.songs.each_with_index do |s_obj, i|
      #   puts "  #{i+1}.#{s_obj.name} - #{s_obj.genre.name}"
      # end
      done = true
    end
  end
  if (starts_with_array.size == 1) && (done == false)
    ans = starts_with_array[0]
  elsif (starts_with_array.size > 1) && (done == false)
    starts_with_array.each do |art_obj|
      es = "s"
      es = "" if art_obj.songs.size == 1
      if y
        puts "#{art_obj.genre.name} - #{art_obj.genre.songs.size} Song#{es}, #{art_obj.genre.artists.size} Artist#{es}"
      else
        puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
      end
    end
  elsif done
    if y
      songs_page(ans)
    else
      es = "s"
      es = "" if ans.songs.size == 1
      puts "#{ans.name} - #{ans.songs.size} Song#{es}"
      ans.songs.each_with_index do |s_obj, i|
        puts "  #{i+1}.#{s_obj.name} - #{s_obj.genre.name}"
      end
    end
  end
  done = true if ans == "q"
  artist_songs unless done
end

def songs_page(ans)
  Song.all.each do |s_obj|
    if ans == s_obj.name 
      puts "Title: #{s_obj.name}"
      puts "Artist: #{s_obj.artist.name}"
      puts "Genre: #{s_obj.genre.name}"
    end
  end
end

def genre
  sort_g = Genre.all.sort_by { |g_obj| g_obj.name }
  sort_g.each do |g|
    es = "" if g.songs.size == 1
    es = "s" if g.songs.size > 1
    puts "#{g.name} - #{g.songs.size} Song#{es}, #{g.artists.size} Artist#{es}" # the es on Artist is cheating
  end
  puts "Type name of genre for details"
  ans = gets.chomp
  Genre.all.each do |g_obj|
    if ans == g_obj.name 
      es = "s"
      es = "" if g_obj.songs.size == 1
      puts "#{g_obj.name} - #{g_obj.songs.size} Song#{es}, #{g_obj.artists.size} Artist#{es}"
      g_obj.songs.each_with_index do |s_obj, i|
        puts "  #{i+1}.#{s_obj.artist.name} - #{s_obj.name}"
      end
    end
  end
  artist_songs(true)
end

def play
  puts "Browse by artist or genre."
  ans = gets.chomp
  while (%w(artist genre h q).include? ans) == false
    puts "Type h for help."
    ans = gets.chomp
  end
  if ans == "artist"
    # print list of artists alphabetical with song number 
    artist
  elsif ans == "genre"
    # print list of genres from most songs to least
    genre
  elsif ans == "h"
    puts "--------------------------------------------------------------"
    puts "Commands:"
    puts "artist  for list of artists."
    puts "genre   for list of genres."
    puts "q       for quit."
    puts "--------------------------------------------------------------"
  end
  ans
end

generate
want = true
while want
  last_input = play
  want = false if last_input == "q"
end








