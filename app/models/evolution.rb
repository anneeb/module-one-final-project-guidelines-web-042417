class Evolution < ActiveRecord::Base
  has_many :pokemon, through: :pokemon_evolutions
end
