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
      opponent_attacks
    else
      opponent_attacks
      user_attacks
    end

  end


  def user_attacks
    puts "#{user_pkmn.name} attacks #{opp_pkmn.name}"

    #caluculates dmg to opponent based on types

  end

  def opponent_attacks
    puts "#{opp_pkmn.name} attacks #{opp_pkmn.name}"
  end


end
