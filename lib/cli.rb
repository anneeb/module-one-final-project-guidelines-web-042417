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
      #go to battle
    when "2"
      #go to lineup
    else
      puts "Invalid input. Please try again"
      main_options
    end
  end

  def start_battle
    #generate pokemon = Adapter.getRandomPokemon
    #battle = BattlePokemon.new(@user, pokemon)
    puts "You are now battle #{pokemon.name}"
    play_first_turn(battle)
  end

  def play_first_turn(battle)
    message = battle.first_turn
    case message
    when -1
      #error
    when 1
      #user turn to attack or switch
    when 2
      #user turn to switch pokemon since current fainted

    end

  end

  def battle_pokemon(battle)

  end


  ## battle_trainer

  ##def battle_trainer
    #opposing_trainer = Opponent.new
    #battle_with_trainer = BattleTrainer.new(opponent_trainer)
    #Battle
    ##find a trainer/populate with pokemon --- Pokemon.create_at_random(MyPokemon.avg_lvl)
    #1. pick move
    #2. pick another pokemon

  end

  #battle_wild_pokemon
  #def battle_wild_pokemon
    #opponent_pokemon = Pokemon.new
    #battle_with_pokemon = BattlPokemon.new(@user, opponent_pokemon)
    ###while battle_with_pokemon.battle_ongoing
      ##user_choice = gets.chomp
      ##battle_with_pokemon.play_turn(user_choice)
    #1. pick move
    #2. pick pokemon
    #3. use pokeball
  ##end

  #change lineup
  def change_lineup
    #
  end


end
