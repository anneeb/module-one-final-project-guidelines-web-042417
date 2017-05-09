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
    #if load then @user = picked user else @user = user.new
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
      battle
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
      throw_pokeball(user, opponent_pokemon)
    when "4"
      puts "You've run away"
      main_options
    else
      battle(user_pokemon, opponent_pokemon)
    end


  end



  end



  def change_lineup
    #
  end


end
