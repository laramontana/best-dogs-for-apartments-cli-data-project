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

  def self.scrape_breed_page(breed_page_url)
    doc = Nokogiri::HTML(open("#{breed_page_url}"))
    new_info = {}
    doc.css("div .care-item.slide").each do |info_slide|
      heading = info_slide.css("h3").text
      new_info[:nutrition_and_feeding] = info_slide.css("p").text if heading.include?("Feeding")
      new_info[:coat_and_grooming] = info_slide.css("p").text if heading.include?("Coat")
      new_info[:exercise] = info_slide.css("p").text if heading.include?("Exercise")
      new_info[:health] = info_slide.css("p").text if heading.include?("Health")
    end
    new_info
  end


end
