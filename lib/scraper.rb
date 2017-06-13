require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_main_page(main_page_url)
    doc = Nokogiri::HTML(open("#{main_page_url}"))
    doc.css("div .scale-contents").collect do |dog_card|
      {
        :breed => dog_card.css("h2 a").text,
        :description => dog_card.css("p").text.gsub(".", ""),
        :breed_url => "http://www.akc.org" + dog_card.css("a").attr("href").value
      }
    end
  end

  def self.scrape_breed_page(breed_page_url)
    doc = Nokogiri::HTML(open("#{breed_page_url}"))
    new_info = {}
    doc.css("div .care-item.slide").each do |info_slide|
      heading = info_slide.css("h3").text
      new_info[:nutrition_and_feeding] = info_slide.css("p").text.gsub("Read More", "") if heading.include?("Feeding")
      new_info[:coat_and_grooming] = info_slide.css("p").text.gsub("Read More", "") if heading.include?("Coat")
      new_info[:exercise] = info_slide.css("p").text.gsub("Read More", "") if heading.include?("Exercise")
      new_info[:health] = info_slide.css("p").text.gsub("Read More", "") if heading.include?("Health")
    end
    new_info
  end
end
