class CLI

  #attr_reader :user
  def initialize
    ##should this be a possibility? how will the data be kept after the user exits?
    #load Trainers.all each Trainer has pokemon stats and you can battle other pokemon and trainers at random
    #@game = Game.new
    #choose to load trainer or create a new one
  end

  def welcome
    puts "Welcome message"
    load_or_create_trainer
    main_options
  end

  def load_or_create_trainer
    puts "Select a trainer to load or create a new one"
    Trainer.all.each_with_index {|trainer, index| puts "#{index + 1}. #{trainer.name}" }
    puts "#{Trainer.all.size + 1}. Create new game "
    input = gets.chomp

    if input.to_i == Trainer.all.size + 1
      @user = create_trainer
    elsif input.to_i > 0 && input.to_i <= Trainer.all.size
      @user = Trainer.all[input.to_i - 1]
    else
      puts "Invalid input. Please try again."
      load_or_create_trainer
    end
  end

  def create_trainer
    puts "What would you like your trainer's name to be?"
    name = gets.chomp
    Trainer.create(name: name)
  end

  def main_options
    puts "Would you like to battle or change your lineup"
    puts "1. Battle"
    puts "2. View and edit lineup"
    input = gets.chomp
    case input
    when "1"
      #go to battle
    when "2"
      #go to lineup
    else
      puts "Invalid input. Please try again"
      main_options
    end
  end

  def battle(user_pokemon = nil, opponent_pokemon = nil)
    opponent_pokemon |= Adapter.get_random_pokemon
    user_pokemon |= @user.pokemon.first_not_fainted
    puts "What would you like to do"
    puts "1. Attack #{opponent_pokemon.name}"
    puts "2. Switch to a different pokemon"
    puts "3. Try to catch pokemon"
    puts "4. Run away"

    user_choice = gets.chomp

    case user_choice
    when "1"
      poke_battle = BattlePokemon.new(user_pokemon, opponent_pokemon)
      poke_battle.play_turn
      battle(user_pokemon, opponent_pokemon)
    when "2"
      switch_pkmn(opponent_pokemon)
    when "3"
      throw_pokeball(poke_battle)
    when "4"
      puts "You've run away"
      main_options
    else
      battle(user_pokemon, opponent_pokemon)
    end

  end

  def switch_pkmn(opponent_pokemon)
    puts "Choose the pokemon you want to use."
    available_pkmn = @user.available_pkmn# gets pokemon names @user.pokemon.reject {|pokemon| pokemon.fainted} #need to have a fainted status for each pokemon and put into User class?
    available_pkmn.each_with_index {|pokemon, index| puts "#{index + 1}. #{pokemon.name}"}
    pkmn_choice = gets.chomp.to_i
    if pkmn_choice > 0 && pkmn_choice <= available_pkmn.size
      pkmn_name = available_pkmn[pkmn_choice - 1]
      user_pokemon = Pokemon.find_by_name(pkmn_name) # can get pokemon from user???
      battle(user_pokemon, opponent_pokemon)
    else
      puts "Invalid choice. Please select a pokemon."
      switch_pkmn(opponent_pokemon)
    end
  end

  def throw_pokeball(battle)
    if battle.capture
      puts "Congrats! You've captured #{opponent_pokemon.name}."
      captured_pokemon
    else
      puts "#{opponent_pokemon.name} was too strong to be captured. Try to lower its HP a little more."
      battle(battle.user_pokemon, battle.opponent_pokemon)
    end
  end

  def captured_pokemon
    if #too many pokemon
      #then drop one

    else
      #add pokemon to lineup
    end
  end


  def change_lineup
    #
  end


end
