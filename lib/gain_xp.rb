class GainXP


  def initialize(trainer, defeated_pkmn)
    @trainer, @defeated_pkmn = trainer, defeated_pkmn
    self.give_exp_to_pkmn
  end

  def experience_gain
    l = @defeated_pkmn.level
    s = @trainer.not_fainted.size # The number of Pokémon that participated in the battle and have not fainted"
    exp = (15 * l / s) + 1
  end

  def give_exp_to_pkmn
    pokemon = @trainer.pokemons
    exp_to_give = experience_gain
    puts "---------------------------------------------------------------------"

    pokemon.each do |pokemon|
      curr_exp = pokemon.experience
      new_exp = curr_exp + exp_to_give
      pokemon.update(experience: new_exp)
      puts  "#{pokemon.name.colorize(:blue)} received #{exp_to_give} experience points"
      sleep(0.5)
      pokemon.reload
      LevelOrEvo.new(pokemon).check_status

    end
  end

end
