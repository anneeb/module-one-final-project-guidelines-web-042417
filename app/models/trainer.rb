class Trainer < ActiveRecord::Base
  has_many :pokemons

  attr_accessor :name, :pokeballs

  def initialize(opt = {})
    :name = opt[:name]
    :pokeballs = 100
  end

  def create_starters
    self.pokemons << Pokemon.create_from_number(1)
    self.pokemons << Pokemon.create_from_number(4)
    self.pokemons << Pokemon.create_from_number(7)
  end

end
