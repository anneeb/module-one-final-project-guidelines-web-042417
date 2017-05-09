class Pokemon < ActiveRecord::Base
  has_many :pokemons

  # Initializes with three pokemon and 100 pokeballs
end
