class CLI

  #attr_reader :user
  def initialize
    ##should this be a possibility? how will the data be kept after the user exits?
    #load Trainers.all each Trainer has pokemon stats and you can battle other pokemon and trainers at random
    #@game = Game.new
    #choose to load trainer or create a new one
  end

  def load_or_create_game
    #puts "Do you want to load a saved game or start a new one"
    #if load then @user = picked user else @user = user.new
  end


  def choose_action_group
    #1. Battle next opponent/trainer?
    #2. Battle pokemon/train/try to capture
    #3. Change LineUp

  end


  ## battle_trainer

  def battle_trainer
    #opposing_trainer = Opponent.new
    #battle_with_trainer = BattleTrainer.new(opponent_trainer)
    #Battle
    ##find a trainer/populate with pokemon --- Pokemon.create_at_random(MyPokemon.avg_lvl)
    #1. pick move
    #2. pick another pokemon

  end

  #battle_wild_pokemon
  def battle_wild_pokemon
    #opponent_pokemon = Pokemon.new
    #battle_with_pokemon = BattlPokemon.new(opponent_pokemon)
    #find a pokemon and populate stats
    #1. pick move
    #2. pick pokemon
    #3. use pokeball
  end

  #change lineup
  def change_lineup
    #
  end


end
