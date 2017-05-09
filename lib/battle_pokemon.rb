class BattlePokemon

  attr_reader :opp_pkmn, :user, :battle_ongoing, :user_pkmn, :user_first_attker

  def initialize(user, user_pkmn opp_pkmn)
    @battle_ongoing = true
    @user, @user_pkmn, @opp_pkmn = user, user_pkmn, opp_pkmn
    @user_first_attker = (@user_pkmn.speed >= opp_pkmn.speed) ? true : false
  end


  def play_turn

    #pokemon attack each other unless one of them faints
    if @user_first_attker
      #user_pokemon attacks opponent pokemon
      #opponent attacks user
    else
      #vice versa
    end

  end


  def user_attacks
    
    #caluculates dmg to opponent based on types

  end

  def opponent_attacks
  end


end
