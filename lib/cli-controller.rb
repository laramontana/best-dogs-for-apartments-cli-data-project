require_relative "../lib/scraper.rb"
require_relative "../lib/dog.rb"
require 'open-uri'
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
    menu
  end

  def menu
    puts "Enter a number of a dog to learn details".colorize(:blue)
    @answer = gets.strip.to_i
    if @answer.between?(1, Dog.all.size)
      details
    else puts "Invalid input, please try again"
      menu
    end
  end
  
  def details
    puts "#{Dog.all[@answer-1].breed}".upcase.colorize(:red)
    puts "FEEDING & NUTRITION: ".colorize(:blue) + "#{Dog.all[@answer-1].nutrition_and_feeding}"
    puts "COAT & GROOMING: ".colorize(:blue) + "#{Dog.all[@answer-1].coat_and_grooming}"
    puts "HEALTH: ".colorize(:blue) + "#{Dog.all[@answer-1].health}"
    puts "EXERCISE: ".colorize(:blue) + "#{Dog.all[@answer-1].exercise}"
    puts " "

    answer = nil
    while answer != "exit"
      puts "Type 'more' to learn more about this breed or 'back' to go back to the list of all breeds".colorize(:blue)
      puts "or type 'exit'".colorize(:blue)

      answer = gets.strip.downcase
      case answer
      when "more" then open_in_browser
      when "back" then list
      when "exit" then exit
      else puts "Invalid input, please try again"
      end
    end
  end

  def open_in_browser
    puts "Please check #{Dog.all[@answer-1].breed_url} for for information!"
    #system("open #{Dog.all[@answer-1].breed_url}") => Couldn't get a file descriptor referring to the console

    answer = nil
    while answer != "n"
      puts "Would you like to start over again? Y/N".colorize(:blue)

      answer = gets.strip
      case answer
      when "y" then list
      when "n" then exit
      else puts "Invalid input, please try again"
      end
    end
  end

end
