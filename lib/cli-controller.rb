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
      @answer = nil

      while @answer == nil
      @answer = gets.strip.to_i

      if  @answer.between?(1, Dog.all.size)
         details
       elsif !@answer.between?(1, Dog.all.size) || !@answer.class.integer?
         puts "Invalid input, please try again"
         @answer = gets.strip.to_i
       end
    end
  end


  def details
    puts "#{Dog.all[@answer-1].breed}".upcase.colorize(:red)
    puts "FEEDING & NUTRITION: ".colorize(:blue) + "#{Dog.all[@answer-1].nutrition_and_feeding}"
    puts "COAT & GROOMING: ".colorize(:blue) + "#{Dog.all[@answer-1].coat_and_grooming}"
    puts "HEALTH: ".colorize(:blue) + "#{Dog.all[@answer-1].health}"
    puts "EXERCISE: ".colorize(:blue) + "#{Dog.all[@answer-1].exercise}"
    puts " "
    puts "Enter 'more' to learn more about this breed".colorize(:blue)
    puts "Enter 'back' to go back to the list of all breeds".colorize(:blue)

    @detail_answer = gets.strip

    if  @detail_answer.downcase == "more"
       open_in_browser
     elsif @detail_answer.downcase == "back"
       list
     elsif @detail_answer.downcase != "more" && @detail_answer.downcase != "back"
       puts "Invalid input, please try again"
     end

  end

  def open_in_browser

    puts "#{Dog.all[@answer-1].breed_url}"

    # system("open'#{Dog.all[@answer-1].breed_url}'")

    puts "Would you like to star over again? Y/N".colorize(:blue)

    @open_in_browser_answer = gets.strip

    if  @open_in_browser_answer.downcase == "y"
       list
     elsif @open_in_browser_answer.downcase == "n"
       exit
     elsif @open_in_browser_answer.downcase != "y" && @open_in_browser_answer.downcase != "n"
       puts "Invalid input, please try again"
     end
  end

end
