class Pokemon < ActiveRecord::Base
  belongs_to :trainer
  has_many :pokemon_types
  has_many :types, through: :pokemon_types
  has_many :pokemon_evolutions
  has_many :evolutions, through: :pokemon_evolutions

  def parse_info_from_api(resp)
    info = {
      name: resp["name"]
      pokemon_number: resp["pkdx_id"]
      types: resp["types"]
      catch_rate: resp["catch_rate"]
      types: []

      hp: resp["hp"]
      attack: resp["attack"]
      defense: resp["defense"]
      special_attack: resp["sp_atk"]
      special_defense: resp["sp_def"]

      growth_rate: resp["growth_rate"]
      evolutions: {}
      speed: resp["speed"]
      weight: resp["weight"]
    }

    resp["evolutions"].each do |evo|
      info[:evolutions][evo["level"]] = evo["resource_uri"] if evo["method"] == "level_up"
    end

    resp["types"].each do |type|
      info[:types] << type["name"]
    end
    info
  end

  def

end
