class Pokemon < ActiveRecord::Base
  belongs_to :trainer
  has_many :pokemon_types
  has_many :types, through: :pokemon_types
  has_many :pokemon_evolutions
  has_many :evolutions, through: :pokemon_evolutions

  def self.create_random_from_level(level:)
    resp = Adapter.get_random_pokemon
    info = parse_info(resp)
    new_pokemon = self.new(info)
    new_pokemon.set_level_and_exp(level)
    new_pokemon.set_hp
    parse = parse_types_and_evos(resp)
    new_pokemon.add_types_from_parse(parse)
    new_pokemon.save
    new_pokemon
  end

  def self.create_from_number_and_level(number:, level:)
    resp = Adapter.get_pokemon_by_number(number)
    info = parse_info(resp)
    new_pokemon = self.new(info)
    new_pokemon.set_level_and_exp(level)
    new_pokemon.set_hp
    parse = parse_types_and_evos(resp)
    new_pokemon.add_types_from_parse(parse)
    new_pokemon.add_evos_from_parse(parse)
    new_pokemon.save
    new_pokemon
  end

  def set_hp
    self.hp = self.level_hp
  end

  def set_level_and_exp(level)
    self.level = level
    self.experience = level_to_exp(level)
  end

  def add_types_from_parse(hash)
    hash[:types].each do |type_name|
      type = Type.find_or_create_by(name: type_name)
      self.types << type
    end
  end

  def add_evos_from_parse(hash)
    hash[:evolutions].each do |k, v|
      level = k
      number = v.split("/").last.to_i
      self.evolutions << Evolution.create(level: level, new_pokemon_number: number)
    end
  end

  def self.parse_info(resp)
    info = {}
    resp.each do |k, v|
      case k
      when "name", "catch_rate", "attack", "defense", "growth_rate", "speed"
        info[k.to_sym] = v
      when  "hp"
        info[:base_hp] = v
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

  def self.parse_types_and_evos(resp)
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
          info[:types] << type["name"].upcase
        end
      end
    end
    info
  end

  def level_to_exp(level)
    n = level
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


  def list_types
    self.types.map do |type|
      type.name
    end
  end

  def take_damage(dmg)
    curr_hp = self.hp
    new_hp = curr_hp - dmg
    self.update(hp: new_hp)
    self.reload
  end

  def next_evolution
    self.evolutions.map do |evolution|
      evolution.level
    end.minimum
  end

  def self.create_random_from_trainer_levels(trainer)
    avg_not_fainted = trainer.get_avg_lvl
    range_around_avg = avg_not_fainted > 5 ? Range.new(avg_not_fainted - 5,avg_not_fainted + 5) : Range.new(1,avg_not_fainted + 5)
    self.create_random_from_level(level: rand(range_around_avg))
  end

  def level_hp
    hp = ((2 * self.base_hp + 100) * self.level) / 100 + 10
  end

end
