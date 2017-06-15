class Dog
  attr_accessor :breed, :description, :breed_url, :nutrition_and_feeding, :coat_and_grooming, :exercise, :health

  @@all = []

  def self.all
    @@all
  end

  def initialize(dog_main_info)
    dog_main_info.each {|k,v| self.send("#{k}=", v)}
    self.class.all << self
  end

  #def self.create_dogs_with_main_info(dogs_main_info)
  #  dogs_main_info.each {|dog_main_info| new_dog = self.new(dog_main_info)}
  #end

  def add_dog_details(details)
    details.each {|k, v| self.send("#{k}=", v)}
  end

end
