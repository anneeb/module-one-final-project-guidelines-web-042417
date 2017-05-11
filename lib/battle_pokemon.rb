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
      #binding.pry
      #--------------------------------------------
      #outcome 1. continue as normal, both pkmn alive
      #outcome 2. opp pkmnn fainted
      #outsome 3. usr pkmn fainted
      if opp_pkmn.hp == 0
        "You defeated the opponent"
      elsif user_pkmn.hp == 0
        "Your pokemon fainted"
      else
        "Both Pokemon can still fight"
      end

    else
      opponent_attacks
      user_attacks unless user_pkmn.hp == 0
      #binding.pry
      if opp_pkmn.hp == 0
        "You defeated the opponent"
      elsif user_pkmn.hp == 0
        "Your pokemon fainted"
      else
        "Both Pokemon can still fight"
      end
    end

  end

  def set_atk_types(atk_types)
    @usr_atk_type = atk_types[0]
    @opp_atk_type = atk_types[1]
  end


  def user_attacks
    puts "#{user_pkmn.name.colorize(:blue)} attacks #{opp_pkmn.name.colorize(:red)} with #{@usr_atk_type.name}"
    sleep(0.5)
    #binding.pry
    dmg_calc = Damage.new(@user_pkmn, @opp_pkmn, @usr_atk_type)
    max_dmg_dealt = dmg_calc.damage.round(0)
    #binding.pry
    #DamageCalculator(attk_type_and_stats, def_type_type_and_stats)
    #if opp.hp > damaage then opp hp +- damage else opp.hp = 0

    #caluculates dmg to opponent based on types
    if opp_pkmn.hp > max_dmg_dealt
      puts "--#{opp_pkmn.name.colorize(:red)} received #{max_dmg_dealt} dmg"
      sleep(0.5)
      opp_pkmn.take_damage(max_dmg_dealt)
      puts "--#{opp_pkmn.name.colorize(:red)} has #{opp_pkmn.hp} hp left"
      sleep(0.5)
    else
      puts "--#{opp_pkmn.name.colorize(:red)} received #{opp_pkmn.hp} dmg"
      sleep(0.5)
      dmg_dealt = opp_pkmn.hp
      opp_pkmn.take_damage(dmg_dealt)
      puts "--#{opp_pkmn.name.colorize(:red)} has #{opp_pkmn.hp} hp left"
      sleep(0.5)
    end

  end

  def opponent_attacks
    sleep(0.5)
    puts "#{opp_pkmn.name.colorize(:red)} attacks #{user_pkmn.name.colorize(:blue)} with #{@opp_atk_type.name}"
    dmg_calc = Damage.new(@opp_pkmn, @user_pkmn, @opp_atk_type)
    max_dmg_dealt = dmg_calc.damage.round(0)

    if user_pkmn.hp > max_dmg_dealt
      puts "--#{user_pkmn.name.colorize(:blue)} received #{max_dmg_dealt} dmg"
      sleep(0.5)
      user_pkmn.take_damage(max_dmg_dealt)
      puts "--#{user_pkmn.name.colorize(:blue)} has #{user_pkmn.hp} hp left"
      sleep(0.5)
    else
      puts "--#{user_pkmn.name.colorize(:blue)} received #{user_pkmn.hp} dmg"
      sleep(0.5)
      dmg_dealt = user_pkmn.hp
      user_pkmn.take_damage(dmg_dealt)
      puts "--#{user_pkmn.name.colorize(:blue)} has #{user_pkmn.hp} hp left"
      sleep(0.5)
    end

  end


end
