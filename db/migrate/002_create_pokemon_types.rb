class CreatePokemonTypes < ActiveRecord::Migration
  def change
    create_table :pokemon_types do |t|
      t.referece :pokemon_id
      t.referece :type_id
    end
  end
end
