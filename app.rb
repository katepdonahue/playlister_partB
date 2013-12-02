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
  starts_with_array = []
end

# turned into class methods, make sure to call .each on the array and then call menu inside iteration
# def genre_menu(array)
#   array.each do |g|
#     es = "" if g.songs.size == 1
#     es = "s" if g.songs.size > 1
#     puts "#{g.name} - #{g.songs.size} Song#{es}, #{g.artists.size} Artist#{es}" # the es on Artist is cheating
#   end
# end

# def art_menu(array)
#   array.each do |art_obj|
#     es = "s"
#     es = "" if art_obj.songs.size == 1
#     puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
#   end
# end

def print_form(inp, array, d)
  if (array.size == 1) && (d == false)
    inp = array[0]
    d = true
    art_details(inp)
  elsif (array.size > 1) && (d == false)
    array.each do |obj|
      obj.page
    end
  end
end

def artist
  Artist.all.each { |x| x.menu }
  artist_songs
end

def artist_songs(y = false)
  extra = "or song " if y
  puts "Type name of artist #{extra}for details"
  ans = gets.chomp
  done = false
  starts_with_array = []
  narrow_art(ans, done)
  print_form(art_menu, ans, starts_with_array, done)
  if y
    narrow_song(ans, done)
    print_form(genre_menu, ans, starts_array, done, song_details)
  end
  done = true if ans == "q"
  artist_songs(y) unless done
end

# def song_page(ans, d)
#   Song.all.each do |s_obj|
#     if ans == s_obj.name 
#       puts "Title: #{s_obj.name}"
#       puts "Artist: #{s_obj.artist.name}"
#       puts "Genre: #{s_obj.genre.name}"
#     end
#   end
#   d = true
# end

def genre
  genre_menu(Genre.all.sort_by { |g_obj| g_obj.name })
  puts "Type name of genre for details"
  ans = gets.chomp
  Genre.all.each do |g_obj|
    if ans == g_obj.name 
      g_obj.page
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


# def artist_songs(y = false)
#   extra = "or song " if y
#   puts "Type name of artist #{extra}for details"
#   ans = gets.chomp
#   done = false
#   starts_with_array = []
#   Artist.all.each do |art_obj|
#     if (ans != art_obj.name) && (art_obj.name.start_with? ans)

#       starts_with_array << art_obj
#     elsif ans == art_obj.name 
#       ans = art_obj
#       done = true
#     end
#   end
#   if (starts_with_array.size == 1) && (done == false)
#     ans = starts_with_array[0]
#     done = true
#   elsif (starts_with_array.size > 1) && (done == false)
#     starts_with_array.each do |art_obj|
#       es = "s"
#       es = "" if art_obj.songs.size == 1
#       if y
#         puts "#{art_obj.genre.name} - #{art_obj.genre.songs.size} Song#{es}, #{art_obj.genre.artists.size} Artist#{es}"
#       else
#         puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
#       end
#     end
#   end
#   if done
#     if y
#       songs_page(ans)
#     else
#       es = "s"
#       es = "" if ans.songs.size == 1
#       puts "#{ans.name} - #{ans.songs.size} Song#{es}"
#       ans.songs.each_with_index do |s_obj, i|
#         puts "  #{i+1}.#{s_obj.name} - #{s_obj.genre.name}"
#       end
#     end
#   end
#   done = true if ans == "q"
#   artist_songs unless done
# end





