require_relative "../lib/scraper.rb"
require_relative "../lib/dog.rb"
require 'nokogiri'
require 'colorize'

class CLIController

  def run
    make_new_dogs
    add_dogs_details
    start
  end

end
