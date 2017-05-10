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
    Trainer.all.each.with_index(1) {|trainer, idx| puts "#{idx}. #{trainer.name}" }
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
    puts "2. View or edit lineup"
    puts "0. Exit the game"
    input = gets.chomp
    case input
    when "1"
      battle
    when "2"
      view_or_edit_lineup
    when "0"
      exit
    else
      puts "Invalid input. Please try again"
      main_options
    end
  end

  def battle(user_pokemon = nil, opponent_pokemon = nil, poke_battle = nil)
    user_pokemon = user_pokemon
    opponent_pokemon = opponent_pokemon
    opponent_pokemon = Pokemon.create_random_from_level(level: 2) unless opponent_pokemon

    #to be changed back to random once pokeapi works again
    #opponent_pokemon = Pokemon.find_by(pokemon_number: 7) unless opponent_pokemon


    #to be altered once better methods become available
    #poke_list = @user.first_not_fainted
    #will simply take the first pokemon in list at current state
    poke_list = @user.list_pokemons
    first_pkmn_name = poke_list.first
    first_pkmn = Pokemon.find_by_name(first_pkmn_name)
    user_pokemon = first_pkmn unless user_pokemon

    puts "You are battling #{opponent_pokemon.name} with #{user_pokemon.name}!"
    ####
    puts "What would you like to do"
    puts "1. Attack #{opponent_pokemon.name}"
    puts "2. Switch to a different pokemon"
    puts "3. Try to catch pokemon"
    puts "4. Run away"

    user_choice = gets.chomp

    case user_choice
    when "1"

      #poke_battle.play_turn
      attack_types = choose_attack(user_pokemon, opponent_pokemon)
      poke_battle = BattlePokemon.new(user_pokemon, opponent_pokemon) unless poke_battle
      poke_battle.set_atk_types(attack_types)
      poke_battle.play_turn
      #play_out_battle(poke_battle)

      #puts "You are trying to battle #{opponent_pokemon.name}. Keep on battling" ##edit so that it will work with BattlePokemon
      battle(user_pokemon, opponent_pokemon, poke_battle)
    when "2"
      switch_pkmn(user_pokemon, opponent_pokemon)
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

    attack_types = []
    puts "Choose which type of attack you want to use."
    user_pkmn_types.each_with_index {|type, index| puts "#{index + 1}. #{type.name}"}
    user_choice = gets.chomp.to_i
    if user_choice > 0 && user_choice <= user_pkmn_types.size
      attack_types << user_pkmn_types[user_choice - 1]
      attack_types << opp_pkmn_types.sample
      attack_types #shovels in a random choice fromn the opponents types
    else
      choose_attack(user_pkmn, opp_pkmn)
    end
  end

  def switch_pkmn(user_pokemon, opponent_pokemon)
    trainer = user_pokemon.trainer
    options = trainer.pokemons.order(:slot).select {|pokemon| pokemon != user_pokemon}
    if options.length == 0
      puts "You don't have any other Pokemon to switch to!"
      battle(user_pokemon, opponent_pokemon)
    end
    puts "Which pokemon would you like to switch to?"
    options.each.with_index(1) do |pokemon, idx|
      puts "#{idx}. #{pokemon.name} (type: #{pokemon.list_types.join(", ")}, level: #{pokemon.level}, hp: #{pokemon.hp})" if pokemon != user_pokemon
    end
    input = gets.chomp
    range = (1..options.length).map {|num| num.to_s}
    if range.include?(input)
      new_pokemon = options[input.to_i - 1]
      if new_pokemon.hp == 0
        puts "You cannot select that Pokemon because it has fainted! Please try again."
        switch_pkmn(user_pokemon, opponent_pokemon)
      else
        battle(new_pokemon, opponent_pokemon)
      end
    else
      puts "Invalid input. Please try again"
      switch_pkmn(user_pokemon, opponent_pokemon)
    end
  end


  ### Post battle level up and evolution:
  ##### LevelOrEvo.new(pokemon).check_status
  ### Where pokemon is the pokemon you potentially are going to level up or evolve

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

  def view_or_edit_lineup
    display_lineup
    puts "Do you want to change your lineup?"
    puts "1. Yes"
    puts "2. No"
    input = gets.chomp
    case input
    when "1"
      change_lineup
    when "2"
      main_options
    else
      puts "Invalid input. Please try again"
      view_or_edit_lineup
    end
  end

  def change_lineup
    count = 1
    @user.pokemons.update_all(slot: nil)
    count_max = @user.pokemons.length
    while count <= count_max
      input = ""
      while input
        puts "Which pokemon do you want for position #{count}?"
        @user.pokemons.where(slot: nil).each.with_index(1) do |pokemon, idx|
          puts "#{idx}. #{pokemon.name} (type: #{pokemon.list_types.join(", ")}, level: #{pokemon.level}, hp: #{pokemon.hp})"
        end
        input = gets.chomp
        range = (1..@user.pokemons.where(slot: nil).length).map {|num| num.to_s}
        break if range.include?(input)
        puts "Invalid input. Please try again"
      end
      id = @user.pokemons.where(slot: nil)[input.to_i - 1][:id]
      Pokemon.find(id).update(slot: count)
      count += 1
    end
    display_lineup
    main_options
  end

  def display_lineup
    puts "Your current lineup is:"
    @user.pokemons.order(:slot).each do |pokemon|
      puts "#{pokemon.slot}. #{pokemon.name} (type: #{pokemon.list_types.join(", ")}, level: #{pokemon.level}, hp: #{pokemon.hp})"
    end
  end

end
