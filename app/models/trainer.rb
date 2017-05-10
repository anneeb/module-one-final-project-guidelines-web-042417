class Trainer < ActiveRecord::Base
  has_many :pokemons

  def create_starters
    self.create_and_add_from_num_and_level(number: 1, level: 5)
    self.create_and_add_from_num_and_level(number: 4, level: 5)
    self.create_and_add_from_num_and_level(number: 7, level: 5)
  end

  def list_pokemons
    self.pokemons.order(:slot).map do |pokemon|
      pokemon.name
    end
  end

  def create_and_add_from_num_and_level(number:, level:)
    new_pokemon = Pokemon.create_from_number_and_level(number: number, level: level)
    new_pokemon.slot = self.pokemons.length + 1
    self.pokemons << new_pokemon
  end

end
