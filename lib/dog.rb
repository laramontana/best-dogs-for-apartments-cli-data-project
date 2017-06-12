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
# a = Dog.new({:breed=>"Bulldog",
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
  def add_dog_details(details)
    details.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  # a.add_dog_new_info({:nutrition_and_feeding=>
  #   "Good nutrition for Bulldogs is very important from puppyhood to his senior years.",
  #  :coat_and_grooming=>"The breed requires minimal grooming and exercise. ",
  #  :exercise=>
  #   "Not Very Active; Bulldogs won't beg to be exercised, but they require regular walks and the occasional romp.",
  #  :health=>"Bulldogs are generally a healthy breed."})

end
