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
      #if hp == 0 then continue turn
      opponent_attacks unless opp_pkmn.hp == 0
      #if hp == 0 then tell user and make them switch pkmn
      #should i pass message numbers for outcomes?
      #outcome 1. continue as normal, both pkmn alive
      #outcome 2. opp pkmnn fainted
      #outsome 3. usr pkmn fainted
    else
      opponent_attacks
      user_attacks unless user_pkmn.hp == 0
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
    else
      puts "#{opp_pkmn.name} received #{opp_pkmn.hp} dmg and fainted"
    end

  end

  def opponent_attacks
    puts "#{opp_pkmn.name} attacks #{user_pkmn.name} with #{@opp_atk_type.name} move"
    #binding.pry
    dmg_calc = Damage.new(@opp_pkmn, @user_pkmn, @opp_atk_type)
    max_dmg_dealt = dmg_calc.damage.round(0)

    if user_pkmn.hp > max_dmg_dealt
      puts "#{user_pkmn.name} received #{max_dmg_dealt} dmg"
    else
      puts "#{user_pkmn.name} received #{user_pkmn.hp} dmg and fainted"
    end

  end


end
