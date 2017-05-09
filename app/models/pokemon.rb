class Pokemon < ActiveRecord::Base
  belongs_to :trainer
  has_many :pokemon_types
  has_many :types, through: :pokemon_types
  has_many :pokemon_evolutions
  has_many :evolutions, through: :pokemon_evolutions

  def parse_info_from_api(resp)
    info = {}
    resp.each do |k, v|
      case k
      when "name" || "types" || "hp" || "catch_rate" || "attack" || "defense" || "growth_rate" || "speed" || "weight"
        info[k.to_sym] = v
      when "pkdx_id"
        info[:pokemon_number] = v
      when "sp_atk"
        info[:special_attack] = v
      when "sp_def"
        info[:special_defense] = v
      when "evolutions"
        v.each do |evo|
          info[:evolutions][evo["level"]] = evo["resource_uri"] if evo["method"] == "level_up"
        end
      when "types"
        if info[:types]
          info[:types] << type["name"]
        else
          info[:types] = []
          info[:types] << type["name"]
        end
      end
    end
    info
  end
