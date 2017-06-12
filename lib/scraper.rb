require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  # "http://www.akc.org/dog-breeds/best-dogs-for-apartments/")
  # http://www.akc.org/dog-breeds/best-dogs-for-apartments/)


  def self.scrape_main_page(main_page_url)
    doc = Nokogiri::HTML(open("#{main_page_url}"))
    doc.css(".event.scale-img-parent").collect do |dog_card|
      binding.pry
      {
        :breed => dog_card.css("h2 a").text,
        :description => dog_card.css("h2 p").text,
        :breed_url => dog_card.css("h2 a").attr("href").value
      }

    end
  end


end
