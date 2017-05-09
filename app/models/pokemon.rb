class Pokemon < ActiveRecord::Base
  belongs_to :trainer
  has_many :pokemon_types
  has_many :types, through: :pokemon_types
  has_many :pokemon_evolutions
  has_many :evolutions, through: :pokemon_evolutions

  def self.create_from_number(number)
    resp = Adapter.get_pokemon_by_number(number)
    info = parse_info_from_api(resp)
    info[:level] = 5
    level_to_exp(info)
    self.create(info)
  end

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

  def level_to_exp(info)
    n = info[:level]
    case info[:growth_rate]
    when "fast"
      exp = (4 * n ** 3)/5
    when "medium fast"
      exp = n ** 3
    when "medium slow"
      exp = (6/5) * n ** 3 - 16 * n ** 2 + 100 * n - 140
    when "slow"
      exp = (5 * n ** 3) / 4
    end
  end
