class CreatePokemonEvolutions < ActiveRecord::Migration
  def change
    create_table :pokemon_evolutions do |t|
      t.references :pokemon_id
      t.references :evolution_id
    end
  end
end
