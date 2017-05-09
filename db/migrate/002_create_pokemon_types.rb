class CreatePokemonTypes < ActiveRecord::Migration
  def change
    create_table :pokemon_types do |t|
      t.references :pokemon
      t.references :type
    end
  end
end
