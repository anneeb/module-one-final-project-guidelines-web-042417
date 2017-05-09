class CreateEvolutions < ActiveRecord::Migration
  def change
    create_table :evolutions do |t|
      t.integer :level
      t.integer :new_pokemon_number
    end
  end
end
