require_relative "../lib/scraper.rb"
require_relative "../lib/dog.rb"
require 'nokogiri'
require 'colorize'

class CLIController
  MAIN_PAGE = "http://www.akc.org/dog-breeds/best-dogs-for-apartments/"

  def run
    make_new_dogs
    add_dogs_details
    #start
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

end
