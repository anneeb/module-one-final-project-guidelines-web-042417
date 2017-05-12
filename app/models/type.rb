class Type < ActiveRecord::Base
  has_many :pokemon_types
  has_many :pokemon, through: :pokemon_types

  def color
    case self.name
    when "FIGHTING"
      :red
    when "FIRE"
      :light_red
    when "GRASS"
      :green
    when "BUG"
      :light_green
    when "GROUND", "ROCK"
      :yellow
    when "ELECTRIC"
      :light_yellow
    when "GHOST", "DRAGON"
      :blue
    when "FLYING"
      :light_blue
    when "POISON"
      :magenta
    when "FAIRY", "PSYCHIC"
      :light_magenta
    when "WATER"
      :cyan
    when "ICE"
      :light_cyan
    else
      :light_black
    end
  end
end
