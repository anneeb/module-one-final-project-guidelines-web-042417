class BattlePokemon

  attr_accessor :current_attker, :users_chosen_pkmn
  attr_reader :opponent_pokemon, :user, :battle_ongoing

  def initialize(user, opponent_pokemon)
    @battle_ongoing = true
    @user = user
    @users_chosen_pkmn = users.first_pokemon ## questionable method
    @opponent_pokemon = opponent_pokemon
    @current_attker = (users_chosen_pkmn.speed >= opponent_pokemon.speed) ? users_chosen_pkmn : opponent_pokemon #question on the speed
    if @current_attker == users_chosen_pkmn
      #puts prompt""
    else
      #opponent attacks
      #puts prompt
    end
    self
  end

  def first_turn
    if user_turn?
      return 1
    else
      #opponent attacks user pokemon
      #if user pkmn still alive then return 1 else return 2
    end
  end

  def play_turn(option)

    #options can be 1. attack, 2. switch pokemon, 3. try to catch
    case option
    when "1"
      #attack
    when "2"
      #switch
    when "3"
      #catch
    else
      -1
    end

  end

  def user_turn?
    if @current_attker == users_chosen_pkmn
      true
    else
      false
    end

  end

  def user_turn

  end

  def opponent_turn
  end


end
