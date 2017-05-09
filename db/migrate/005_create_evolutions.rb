class CreateEvolutions < ActiveRecord::Migration
  def change
    create_table :evolutions do |t|
      t.string :starting_pokemon_id
      t.integer :level
      t.string :new_pokemon_id
    end
  end
end
