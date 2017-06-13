require_relative "../lib/scraper.rb"
require_relative "../lib/dog.rb"
require 'nokogiri'
require 'colorize'

class CLIController
  MAIN_PAGE = "http://www.akc.org/dog-breeds/best-dogs-for-apartments/"

  def run
    make_new_dogs
    add_dogs_details
    list
  end

  def make_new_dogs
    dogs_main_info = Scraper.scrape_main_page(MAIN_PAGE)
    Dog.create_dogs_with_main_info(dogs_main_info)
  end

  def add_dogs_details
    Dog.all.each do |dog|
      details = Scraper.scrape_breed_page(dog.breed_url)
      dog.add_dog_details(details)
    end
  end

  def list
    puts " "
    puts "Top 10 dogs for apartments:".colorize(:red)
    Dog.all.each.with_index(1) {|dog, i| puts "#{i}. #{dog.breed}"}
    puts " "
    puts "Enter a number of a dog to learn details".colorize(:blue)

    @answer = gets.strip.to_i
    details
  end

  def details
    puts "FEEDING & NUTRITION: ".colorize(:blue) + "#{Dog.all[@answer-1].nutrition_and_feeding}"
    puts "COAT & GROOMING: ".colorize(:blue) + "#{Dog.all[@answer-1].coat_and_grooming}"
    puts "HEALTH: ".colorize(:blue) + "#{Dog.all[@answer-1].health}"
    puts "EXERCISE: ".colorize(:blue) + "#{Dog.all[@answer-1].exercise}"
  end

end
