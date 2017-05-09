class BattlePokemon

  attr_accessor :current_attker, :users_chosen_pkmn
  attr_reader :opponent_pokemon, :user, :battle_ongoing

  def initialize(user, opponent_pokemon)
    @battle_ongoing = true
    @user = user
    @users_chosen_pkmn = users.first_pokemon ## questionable method
    @opponent_pokemon = opponent_pokemon
  end


  def play_turn(option)

    #options can be 1. attack, 2. switch pokemon, 3. try to catch
    case option
    when "1"
      attack(@users_chosen_pkmn,@opponent_pokemon)
    when "2"
      switch_pkmn
    when "3"
      throw_pokeball
    else
      -1
    end

  end

  def switch_pkmn
    @user.pokemon.each_with_index {|pokemon, index| puts "#{index + 1}. #{pokemon.name}"}
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
