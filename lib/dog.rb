class Dog
  attr_accessor :breed, :description, :breed_url, :nutrition_and_feeding, :coat_and_grooming, :exercise, :health

  @@all = []

  def initialize(dog_main_info)
    dog_main_info.each {|k,v| self.send("#{k}=", v)}
    @@all << self
  end

  def self.all
    @@all
  end

end

# dog_main_info
# Dog.new({:breed=>"Bulldog",
#   :description=>"Calm, courageous, and friendly; dignified but amusing",
#   :breed_url=>"/dog-breeds/bulldog/"})
