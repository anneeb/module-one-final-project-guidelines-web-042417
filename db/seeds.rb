ash = Trainer.create(name: "Ash")

## strong attcker, fast

pikachu = Pokemon.create_from_number_and_level(number: 25, level: 10)
pikachu.update(experience: pikachu.level_to_exp(11) - 1)
pikachu.update(slot: ash.pokemons.length + 1)
ash.pokemons << pikachu

## pokemon that's going to evolve

caterpie = Pokemon.create_from_number_and_level(number: 10, level: 6)
caterpie.update(experience: caterpie.level_to_exp(7) - 1)
caterpie.update(slot: ash.pokemons.length + 1)
ash.pokemons << caterpie

## weak slow attacker that won't die

slowpoke = Pokemon.create_from_number_and_level(number: 79, level: 16)
slowpoke.update(slot: ash.pokemons.length + 1)
ash.pokemons << slowpoke

ash.reload
