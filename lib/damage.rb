class Damage

  attr_reader :atkr, :defr, :atk_type

  def initialize(atkr, defr, atk_type)
    @atkr, @defr, @atk_type = atkr, defr, atk_type
  end

  def damage
    random = rand(0.85..1.00)
    type_mods = type_resistance(@atk_type, @defr) #array of hashes that have modifiers
    if type_mods.empty?
      total_type_multiplier = 1.0
    else
      type_mods.each {|type_mod| puts "#{@atk_type.name} is #{type_mod[:effect]} against #{type_mod[:type]}" }
      type_multipliers = type_mods.collect {|mod| mod[:mult]}
      total_type_multiplier = type_multipliers.inject{|product, mult| product * mult}
    end
    mods = random * total_type_multiplier * 1.5 # 1.5 represents STAB bonus
    damage = (((2 * @atkr[:level] / 5) + 2) * (@atkr[:special_attack] / @defr[:special_defense]) * 40 / 50 + 2) * mods # 40 represents power of move which is constant since there are no specific moves
  end

  def type_resistance(atkr_type, defer)
    res = []
    a_type = atk_type.name
    defer_types = defer.types.collect {|defer_type| defer_type.name}
      defer_types.each do |d_type|
        case a_type
        when "normal"
          case d_type
          when "rock"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          when "ghost"
            res << {type: d_type, effect: "no effect", mult: 0.0}
          end
        when "fire"
          case d_type
          when "grass", "ice", "bug"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "fire", "water", "rock", "dragon"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "water"
          case d_type
          when "fire", "ground", "rock"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "water", "grass", "dragon"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "electric"
          case
          when "water", "flying"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "electric", "grass", "dragon"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          when "ground"
            res << {type: d_type, effect: "no effect", mult: 0.0}
          end
        when "grass"
          case
          when "water", "ground", "rock"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "fire", "grass", "poison", "flying", "bug", "dragon"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "ice"
          case d_type
          when "grass", "ground", "flying", "dragon"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "water", "ice"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "fighting"
          case d_type
          when "normal", "ice", "rock"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "poison", "flying", "psychic", "bug", "rock"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          when "ghost"
            res << {type: d_type, effect: "no effect", mult: 0.0}
          end
        when "poison"
          case d_type
          when "grass", "bug"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "poison", "ground", "rock", "ghost"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "ground"
          case d_type
          when "fire", "electric", "poison", "rock"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "grass", "bug"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          when "flying"
            res << {type: d_type, effect: "no effect", mult: 0.0}
          end
        when "flying"
          case d_type
          when "grass", "fighting", "bug"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "electric", "rock"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "psychic"
          case d_type
          when "fighting", "poison"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "psychic"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "bug"
          case d_type
          when "grass", "poison", "psychic"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "fire", "fighting", "flying"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "rock"
          case d_type
          when "fire", "ice", "flying", "bug"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "fighing", "ground"
            res << {type: d_type, effect: "not very effective", mult: 0.5}
          end
        when "ghost"
          case d_type
          when "ghost"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          when "normal", "psychic"
            res << {type: d_type, effect: "no effect", mult: 0.0}
          end
        when "dragon"
          case d_type
          when "dragon"
            res << {type: d_type, effect: "super effective", mult: 2.0}
          end
        end
      end
    #what if it falls off the case statement or that it has a normal effect
    res
  end



end
