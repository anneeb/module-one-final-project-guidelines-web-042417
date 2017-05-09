class CreatePokemonEvolutions < ActiveRecord::Migration
  def change
    create_table :pokemon_evolutions do |t|
      t.referece :pokemon_id
      t.referece :evolution_id
    end
  end
end
