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

# dog_main_info
# Dog.new({:breed=>"Bulldog",
#   :description=>"Calm, courageous, and friendly; dignified but amusing",
#   :breed_url=>"/dog-breeds/bulldog/"})

  def self.create_dogs_with_main_info(dogs_main_info)
    dogs_main_info.each do |dog_main_info|
      new_dog = self.new(dog_main_info)
    end
  end


  # dogs_main_info
  # Dog.create_with_main_info([{:breed=>"Bulldog",
  #   :description=>"Calm, courageous, and friendly; dignified but amusing",
  #   :breed_url=>"/dog-breeds/bulldog/"},
  #  {:breed=>"Shih Tzu",
  #   :description=>"Outgoing, affectionate, playful and charming",
  #   :breed_url=>"/dog-breeds/shih-tzu/"},
  #  {:breed=>"Cavalier King Charles Spaniel",
  #   :description=>"Affectionate, graceful, and gentle",
  #   :breed_url=>"/dog-breeds/cavalier-king-charles-spaniel/"}])

end
