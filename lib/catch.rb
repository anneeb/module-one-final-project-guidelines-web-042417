class Catch
  attr_reader :user, :desired_pokemon

  def initialize (user_pokemon, desired_pokemon)
    @user = user_pokemon.trainer
    @desired_pokemon = desired_pokemon
  end

  def caught?
    max_hp = self.desired_pokemon.base_hp
    hp = self.desired_pokemon.hp
    cr = self.desired_pokemon.catch_rate
    m = rand(0..255)
    f = (cr + 1) * (max_hp / hp)
    f >= m ? true : false
  end

  def add_caught_pokemon_with_increment_slot
    new_pokemon_number = self.desired_pokemon.pokemon_number
    level = self.desired_pokemon.level
    self.user.create_and_add_from_num_and_level(number: new_pokemon_number, level: level)
  end

  def add_caught_pokemon_with_replacement(slot)
    new_pokemon_number = self.desired_pokemon.pokemon_number
    level = self.desired_pokemon.level
    trainer = self.user
    new_pokemon = Pokemon.create_from_number_and_level(number: new_pokemon_number, level: level)
    new_pokemon.update(slot: slot)
    trainer.pokemons << new_pokemon
  end
end
