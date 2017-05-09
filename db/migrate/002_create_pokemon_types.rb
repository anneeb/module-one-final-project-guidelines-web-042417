class CreatePokemonTypes < ActiveRecord::Migration
  def change
    create_table :pokemon_types do |t|
      t.references :pokemon_id
      t.references :type_id
    end
  end
end
