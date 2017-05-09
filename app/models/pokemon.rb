class Pokemon < ActiveRecord::Base
  belongs_to :trainer
  has_many :pokemon_types
  has_many :types, through: :pokemon_types
  has_many :pokemon_evolutions
  has_many :evolutions, through: :pokemon_evolutions

  def self.create_from_number_and_level(number: number, level: level)
    resp = Adapter.get_pokemon_by_number(number)
    info = parse_info_from_api(resp)
    new_pokemon = self.new(info)
    new_pokemon.set_level_and_exp(5)
    # new_pokemon.add_types(info)
    # new_pokemon.add
    new_pokemon.save
    new_pokemon
  end

  def set_level_and_exp(level)
    self.level = level
    self.experience = level_to_exp(level)
  end

  def self.get_types_and_evos(resp)
    info = {}
    resp.each do |k, v|
      case k
      when "evolutions"
        info[:evolutions] = {}
        v.each do |evo|
          info[:evolutions][evo["level"]] = evo["resource_uri"] if evo["method"] == "level_up"
        end
      when "types"
        info[:types] = []
        v.each do |type|
          info[:types] << type["name"]
        end
      end
    end
    info
  end

  def add_types(info)
    info[:types].each do |type|
      self.types << type
    end
  end

  def self.parse_info_from_api(resp)
    info = {}
    resp.each do |k, v|
      case k
      when "name", "hp", "catch_rate", "attack", "defense", "growth_rate", "speed"
        info[k.to_sym] = v
      when "pkdx_id"
        info[:pokemon_number] = v
      when "sp_atk"
        info[:special_attack] = v
      when "sp_def"
        info[:special_defense] = v
      end
    end
    info
  end

  def level_to_exp(level)
    n = 5
    case self.growth_rate
    when "fast"
      (4 * n ** 3)/5
    when "medium fast"
      n ** 3
    when "medium slow"
      (6/5) * n ** 3 - 16 * n ** 2 + 100 * n - 140
    when "slow"
      (5 * n ** 3) / 4
    when ""
      ((n ** 3) + ((6/5) * n ** 3 - 16 * n ** 2 + 100 * n - 140)) / 2
    end
  end

end