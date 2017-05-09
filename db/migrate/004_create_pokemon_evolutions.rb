class CreatePokemonEvolutions < ActiveRecord::Migration
  def change
    create_table :pokemon_evolutions do |t|
      t.references :pokemon
      t.references :evolution
    end
  end
end
