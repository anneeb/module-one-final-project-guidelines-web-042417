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
      #go to battle
    when "2"
      change_lineup
    else
      puts "Invalid input. Please try again"
      main_options
    end
  end

  def battle(user_pokemon = nil, opponent_pokemon = nil, poke_battle = nil)
    user_pokemon = user_pokemon
    opponent_pokemon = opponent_pokemon
    opponent_pokemon = Pokemon.create_random_from_level(level: 2) unless opponent_pokemon

    #to be altered once better methods become available
    #poke_list = @user.first_not_fainted
    #will simply take the first pokemon in list at current state
    #need to take first not fainted
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
      poke_battle = BattlePokemon.new(user_pokemon, opponent_pokemon)
      poke_battle.play_turn
      battle(user_pokemon, opponent_pokemon)
    when "2"
      switch_pkmn(opponent_pokemon)
    when "3"
      throw_pokeball(user_pokemon, opponent_pokemon, poke_battle)
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

  def play_out_turn(user_pokemon, opponent_pokemon, poke_battle)
    attack_types = choose_attack(user_pokemon, opponent_pokemon)
    poke_battle = BattlePokemon.new(user_pokemon, opponent_pokemon) unless poke_battle
    poke_battle.set_atk_types(attack_types)
    battle_outcome = poke_battle.play_turn
    case battle_outcome
    when 1
      battle(user_pokemon, opponent_pokemon, poke_battle)
    when 2
      puts "You defeated #{opponent_pokemon.name}"
      ## gain experience
      ## call exp/level up
      ## destroy opp pokemon from database
      main_options
    when 3
      puts "#{user_pkmn.name} fainted"
      auto_select_next_to_battle(opponent_pokemon)
    else
      puts "Error. Something went wrong"
      main_options
    end

    #--------------------------------------------
    #outcome 1. continue as normal, both pkmn alive
    #outcome 2. opp pkmnn fainted
    #outsome 3. usr pkmn fainted
    #play_turn(poke_battle)
  end


  def throw_pokeball(user_pokemon, opponent_pokemon, poke_battle)
    if @user.pokeballs == 0
      puts "You cannot catch #{opponent_pokemon.name} because you're out of pokeballs"
      battle(user_pokemon, opponent_pokemon, poke_battle)
    end
    catchy = Catch.new(user_pokemon, opponent_pokemon)
    @user.update(pokeballs: @user.pokeballs - 1)
    if catchy.caught? == true
      puts "You've caught #{opponent_pokemon.name}! You now have #{@user.pokeballs} pokeballs."
      if @user.pokemons.length == 6
        input = ""
        while input
          puts "You have too many Pokemon and need to make room for #{opponent_pokemon.name}. Which Pokemon do you want to release?"
          @user.pokemons.each.with_index(1) do |pokemon, idx|
            puts "#{idx}. #{pokemon.name} (type: #{pokemon.list_types.join(", ")}, level: #{pokemon.level}, hp: #{pokemon.hp})"
          end
          input = gets.chomp
          range = (1..@user.pokemons.length).map {|num| num.to_s}
          break if range.include?(input)
          puts "Invalid input. Please try again"
        end
        id = @user.pokemons[input.to_i - 1].id
        slot = Pokemon.find(id).slot
        puts "You have released #{@user.pokemons[input.to_i - 1].name}"
        Pokemon.find(id).destroy
        catchy.add_caught_pokemon_with_replacement(slot)
        @user.reload
        main_options
      else
        catchy.add_caught_pokemon_with_increment_slot
        @user.reload
        main_options
      end
    else
      puts "You were not able to catch #{opponent_pokemon.name}. Try lowering it's HP some more."
      puts "You now have #{@user.pokeballs} pokeballs."
      battle(user_pokemon, opponent_pokemon, poke_battle)
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
      Pokemon.destroy(id)
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
