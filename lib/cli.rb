class CLI

  attr_reader :user
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
    new_trainer = Trainer.create(name: name)
    new_trainer.create_starters
    new_trainer

  end

  def main_options
    puts "Would you like to battle or change your lineup"
    puts "1. Battle"
    puts "2. View and edit lineup"
    input = gets.chomp
    case input
    when "1"
      battle
    when "2"
      change_lineup
    else
      puts "Invalid input. Please try again"
      main_options
    end
  end

  def battle(user_pokemon = nil, opponent_pokemon = nil)
    opponent_pokemon = opponent_pokemon
    user_pokemon = user_pokemon
    opponent_pokemon = Pokemon.create_random_from_level(level: 2) unless opponent_pokemon

    #to be altered once better methods become available
    #poke_list = @user.first_not_fainted
    #will simply take the first pokemon in list at current state
    poke_list = @user.list_pokemons
    first_pkmn_name = poke_list.first
    first_pkmn = Pokemon.find_by_name(first_pkmn_name)
    user_pokemon  = first_pkmn unless user_pokemon
    ####

    puts "What would you like to do"
    puts "1. Attack #{opponent_pokemon.name}"
    puts "2. Switch to a different pokemon"
    puts "3. Try to catch pokemon"
    puts "4. Run away"

    user_choice = gets.chomp

    case user_choice
    when "1"
      poke_battle = BattlePokemon.new(user_pokemon, opponent_pokemon)
      #poke_battle.play_turn
      attack_types = choose_attack(user_pokemon, opponent_pokemon)
      #play_out_battle(poke_battle)
      puts "You are trying to battle #{opponent_pokemon.name}. Keep on battling" ##edit so that it will work with BattlePokemon
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

  def choose_attack(user_pkmn, opp_pkmn)
    user_pkmn_types = user_pkmn.types
    opp_pkmn_types = opp_pkmn.types
    #binding.pry

    attack_types = []
    puts "Choose which type of attack you want to use."
    user_pkmn_types.each_with_index {|type, index| "#{index + 1}. #{type}"}
    user_choice = gets.chomp.to_i
    if user_choice > 0 && user_choice <= user_pkmn_types.size
      attack_types << user_pkmn_types[user_choice - 1]
      attack_types << opp_pkmn_types.sample
      attack_types #shovels in a random choice fromn the opponents types
    else
      choose_attack(user_pkmn, opp_pkmn)
    end
  end

  def play_out_battle(battle)
    puts "Which attack would you like to use?"
    #types = battle.get_user_types ###will break at the moment
    #types.each_with_index {|type, index| puts "#{index + 1}. #{type}"} ##will break at the moment
    #puts "#{types.size + 1}. Back to battle menu"
    user_type_choice = gets.chomp.to_i

    #if user_type_choice == 1
    # => battle.play_turn(0)
    #elsif user_type_choice == 2 && types.size == 2
    # => battle.play_turn(1)
    #elsif user_type_choice == 2
    # => battle(battle.user_pkmn, battle.opp_pkmn)
    #elsif user_type_choice == 3 && types.size == 2
    # => battle(battle.user_pkmn, battle.opp_pkmn)
    #else
    # => play_out_battle(battle)
    #end
    test_over = false
    if test_over
      play_out_battle
    else
      main_options
    end

  end


  def switch_pkmn(opponent_pokemon)
    puts "Choose the pokemon you want to use."
    puts "This is part of a test. Code will break because user.available_pkmn methods haven't been implemented yet"
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
    test_capture = false
    if test_capture#battle.capture
      puts "Congrats! You've captured #{opponent_pokemon.name}."
      captured_pokemon
    else
      puts "#{opponent_pokemon.name} was too strong to be captured. Try to lower its HP a little more."
      battle(battle.user_pokemon, battle.opponent_pokemon)
    end
  end

  def captured_pokemon

  end


  def change_lineup
    #
  end


end
