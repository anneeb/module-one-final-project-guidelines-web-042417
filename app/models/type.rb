class Type < ActiveRecord::Base
  has_many :pokemon_types
  has_many :pokemon, through: :pokemon_types
  has_many :types, through: :pokemon_types
end
