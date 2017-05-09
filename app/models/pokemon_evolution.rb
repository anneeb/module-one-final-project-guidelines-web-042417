class PokemonEvolution < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :evolution
end
