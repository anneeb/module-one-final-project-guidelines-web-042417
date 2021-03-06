class LevelOrEvo
  attr_accessor :pokemon

  def initialize(pokemon)
    @pokemon = pokemon
  end

  def check_status
    if self.ready_for_level_up?
      puts "Your #{self.pokemon.name} is ready to level up!"
      run_level_or_evo
    else
    end
  end

  def run_level_or_evo
    if self.ready_for_level_up?
      self.level_up
      if self.ready_for_evo?
        self.evolve
        self.run_level_or_exp
      else
        self.run_level_or_exp
      end
    else
      puts "You now have a level #{self.pokemon.level} #{self.pokemon.name}."
    end
  end

  def ready_for_level_up?
    exp = self.pokemon.experience
    current_level = self.pokemon.level
    next_level = self.pokemon.level + 1
    goal_exp = self.pokemon.level_to_exp(next_level)
    exp > goal_exp ? true : false
  end

  def level_up
    self.pokemon.update(level: self.pokemon.level + 1)
  end

  def ready_for_evo?
    evo_levels = self.pokemon.evolutions.map {|evo| evo.level}
    evo_levels.include?(self.pokemon.level) ? true : false
  end

  def evolve
    old_pokemon = self.pokemon
    old_pokemon_id = self.pokemon.id
    old_pokemon_exp = self.pokemon.experience
    level = self.pokemon.level
    new_pokemon_number = self.pokemon.evolutions.where(level: level).first.new_pokemon_number
    new_pokemon = Pokemon.create_from_number_and_level(number: new_pokemon_number, level: level)
    trainer = self.pokemon.trainer
    slot = self.pokemon.slot
    puts "Your #{old_pokemon.name} has evolved into a #{new_pokemon.name}!!!"
    self.pokemon.destroy
    new_pokemon.update(slot: slot)
    trainer.reload
    trainer.pokemons << new_pokemon
    self.pokemon = new_pokemon
    self.pokemon.update(experience: old_pokemon_exp)
  end
end
