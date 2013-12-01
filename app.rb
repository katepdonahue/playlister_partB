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

def play
  puts "Browse by artist or genre."
  ans = gets.chomp
  while (%w(artist genre h q).include? ans) == false
    puts "Type h for help."
    ans = gets.chomp
  end
  if ans == "artist"
    # print list of artists alphabetical with song number 
    Artist.all.each do |art_obj|
      es = "s"
      es = "" if art_obj.songs.size == 1
      puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
    end
    puts "Type name of artist for songs"
    ans = gets.chomp
    Artist.all.each do |art_obj|
      if ans == art_obj.name 
        es = "s"
        es = "" if art_obj.songs.size == 1
        puts "#{art_obj.name} - #{art_obj.songs.size} Song#{es}"
        art_obj.songs.each_with_index do |s_obj, i|
          puts "  #{i+1}.#{s_obj.name} - #{s_obj.genre.name}"
        end
      end
    end
  elsif ans == "genre"
    # print list of genres
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


# class App
#   attr_reader :names, :twitters, :blogs

#   def initialize
#     my_scraper = Scraper.new "http://flatironschool-bk.herokuapp.com/"
#     @names = my_scraper.get_students_names
#     @twitters = my_scraper.get_twitter
#     @blogs = my_scraper.get_blog
#   end

#   def generate_directory
#     our_class = []
#     28.times do |i|
#       our_class << Student.new(names[i], twitters[i], blogs[i])
#     end
#     our_class
#   end

#   def directory
#     generate_directory.each do |classmate|
#       puts "Name: #{classmate.name},  Twitter: #{classmate.twitter}, Blog: #{classmate.blog}\n"
#     end
#   end

#   def random_blog
#     Launchy.open("#{blogs.sample}")
#   end

#   def random_twitter
#     Launchy.open("twitter.com/#{twitters.sample[1..-1]}")
#   end

#   def blog(stu_name)
#     generate_directory.each do |student_object|
#       if student_object.name.upcase.start_with?(stu_name.upcase)
#         if student_object.blog == "none"; puts "none"
#         else; Launchy.open("#{student_object.blog}"); end
#       end
#     end
#   end

#   def twitter(stu_name)
#     generate_directory.each do |student_object|
#       if student_object.name.upcase.start_with?(stu_name.upcase)
#         if student_object.twitter == "none"; puts "none"
#         else; Launchy.open("twitter.com/#{student_object.twitter[1..-1]}"); end
#       end
#     end
#   end

  # def play
  #   puts "Hey, what do you want?"
  #   ans = gets.chomp
  #   while (%w(rand_b rant_t blog twitter q h).include? ans) == false
  #     puts "Type h for help."
  #     ans = gets.chomp
  #   end
  #   if ans == "rand_b"
  #     random_blog
  #   elsif ans == "rand_t"
  #     random_twitter
  #   elsif ans == "blog"
  #     puts "Whose?"
  #     name = gets.chomp
  #     blog(name)
  #   elsif ans == "twitter"
  #     puts "Whose?"
  #     name = gets.chomp
  #     twitter(name)
  #   elsif ans == "h"
  #     puts "--------------------------------------------------------------"
  #     puts "Commands:"
  #     puts "rand_b  for random blog."
  #     puts "rand_t  for random twitter."
  #     puts "blog    for specific blog (you will be prompted for name)."
  #     puts "twitter for specific twitter (you will be prompted for name)."
  #     puts "q       for quit."
  #     puts "--------------------------------------------------------------"
  #   end
  #   ans
  # end

# end


# # game code
# app1 = App.new
# want = true
# while want
#   last_input = app1.play
#   want = false if last_input == "q"
# end






