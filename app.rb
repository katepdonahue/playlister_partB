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

def narrow_art(inp, d)
  starts_with_array = []
  Artist.all.each do |obj|
    if (inp != obj.name) && (obj.name.start_with? inp)
      starts_with_array << obj
    elsif inp == obj.name 
      obj.page
      d = true
    end
  end
  starts_with_array
end

def narrow_song(inp, d)
  starts_with_array = []
  Song.all.each do |obj|
    if (inp != obj.name) && (obj.name.start_with? inp)
      starts_with_array << obj
    elsif inp == obj.name 
      obj.page
      d = true
    end
  end
  starts_with_array
end

def print_list?(inp, array, d)
  if (array.size == 1) && (d == false)
    inp = array[0]
    d = true
    return false
  elsif (array.size > 1) && (d == false)
    return true
  end
end

def artist
  Artist.all.each { |obj| obj.menu }
  art_responder
end

def art_responder
  puts "Type name of artist for details"
  ans = gets.chomp
  done = false
  # we are coming from artist menu screen
  list = narrow_art(ans, done) # returns array of narrowed results artists
  if print_list?(ans, list, done)
    list.each do |art_obj| # print each artist object in artist menu form
      art_obj.menu
    end
  else
    list[0].page # print single artist object (index 0) in artist page form
  end
  end
  done = true if ans == "q"
  art_responder unless done
end

def gen_responder
  puts "Type name of artist or song for details"
  ans = gets.chomp
  done = false
  # we are coming from genre menu screen
  list = narrow_song(ans, done) # returns array of narrowed results songs
  if print_list?(ans, list, done)
    list.each do |song_obj| # print each song object in genre page form
      song_obj.genre.page
    end
  else
    list[0].page # print single song object (index 0) in song page form
  end
  list = narrow_art(ans, done) # returns array of narrowed results artists
  if print_list?(ans, list, done)
    list.each do |art_obj| # print each artist object in genre page form
      art_obj.genre.page
    end
  else
    list[0].page # print single song object (index 0) in song page form
  end
  done = true if ans == "q"
  gen_responder unless done
end

def genre
  sorted_g = Genre.all.sort_by { |g_obj| g_obj.songs.size }
  sorted_g.each { |obj| obj.menu }
  puts "Type name of genre for details"
  ans = gets.chomp
  Genre.all.each do |g_obj|
    if ans == g_obj.name 
      g_obj.page
    end
  end
  gen_responder
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
    puts "-" * 60
    puts "Commands:"
    puts "artist  for list of artists."
    puts "genre   for list of genres."
    puts "q       for quit."
    puts "-" * 60
  end
  ans
end

generate
want = true
while want
  last_input = play
  want = false if last_input == "q"
end


