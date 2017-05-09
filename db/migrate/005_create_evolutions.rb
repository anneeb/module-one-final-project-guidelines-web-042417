class CreateEvolutions < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.text :starting_pokemon_id
      t.integer :level
      t.text :new_pokemon_id
    end
  end
end
