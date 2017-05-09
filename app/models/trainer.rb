class Trainer < ActiveRecord::Base
  has_many :pokemons

  def create_starters
    self.pokemons << Pokemon.create_from_number_and_level(number: 1, level: 5)
    self.pokemons << Pokemon.create_from_number_and_level(number: 4, level: 5)
    self.pokemons << Pokemon.create_from_number_and_level(number: 7, level: 5)
  end

end
