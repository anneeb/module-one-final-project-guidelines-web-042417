class BattlePokemon

  attr_reader :opp_pkmn, :battle_ongoing, :user_pkmn, :user_first_attker

  def initialize(user_pkmn, opp_pkmn)
    @battle_ongoing = true
    @user_pkmn, @opp_pkmn = user_pkmn, opp_pkmn
    @user_first_attker = (@user_pkmn.speed >= opp_pkmn.speed) ? true : false
  end


  def play_turn

    #pokemon attack each other unless one of them faints
    if @user_first_attker
      user_attacks

      opponent_attacks unless opp_pkmn.hp == 0

      #--------------------------------------------
      #outcome 1. continue as normal, both pkmn alive
      #outcome 2. opp pkmnn fainted
      #outsome 3. usr pkmn fainted
      if opp_pkmn.hp == 0
        2
      elsif user_pkmn.hp == 0
        3
      else
        1
      end

    else
      opponent_attacks
      user_attacks unless user_pkmn.hp == 0

      if opp_pkmn.hp == 0
        2
      elsif user_pkmn.hp == 0
        3
      else
        1
      end
    end

  end

  def set_atk_types(atk_types)
    @usr_atk_type = atk_types[0]
    @opp_atk_type = atk_types[1]
  end


  def user_attacks
    puts "#{user_pkmn.name} attacks #{opp_pkmn.name} with #{@usr_atk_type.name} move"
    #binding.pry
    dmg_calc = Damage.new(@user_pkmn, @opp_pkmn, @usr_atk_type)
    max_dmg_dealt = dmg_calc.damage.round(0)
    #binding.pry
    #DamageCalculator(attk_type_and_stats, def_type_type_and_stats)
    #if opp.hp > damaage then opp hp +- damage else opp.hp = 0

    #caluculates dmg to opponent based on types
    if opp_pkmn.hp > max_dmg_dealt
      puts "#{opp_pkmn.name} received #{max_dmg_dealt} dmg"
      opp_pkmn.take_damage(max_dmg_dealt)
      puts "#{opp_pkmn.name} has #{opp_pkmn.hp} hp left"
    else
      puts "#{opp_pkmn.name} received #{opp_pkmn.hp} dmg and fainted"
      opp_pkmn.take_damage(opp_pkmn.hp)
      puts "#{opp_pkmn.name} has #{opp_pkmn.hp} hp left"
    end

  end

  def opponent_attacks
    # binding.pry
    puts "#{opp_pkmn.name} attacks #{user_pkmn.name} with #{@opp_atk_type.name} move"
    #binding.pry
    dmg_calc = Damage.new(@opp_pkmn, @user_pkmn, @opp_atk_type)
    max_dmg_dealt = dmg_calc.damage.round(0)

    if user_pkmn.hp > max_dmg_dealt
      puts "#{user_pkmn.name} received #{max_dmg_dealt} dmg"
      user_pkmn.take_damage(max_dmg_dealt)
      puts "#{user_pkmn.name} has #{user_pkmn.hp} hp left"
    else
      puts "#{user_pkmn.name} received #{user_pkmn.hp} dmg and fainted"
      user_pkmn.take_damage(user_pkmn.hp)
      puts "#{user_pkmn.name} has #{user_pkmn.hp} hp left"
    end

  end


end
