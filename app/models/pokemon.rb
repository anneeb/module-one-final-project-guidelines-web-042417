class Pokemon < ActiveRecord::Base
  belongs_to :trainer
  has_many :pokemon_types
  has_many :types, through: :pokemon_types
  has_many :pokemon_evolutions
  has_many :evolutions, through: :pokemon_evolutions
end
