class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :pokemon_number

      t.integer :catch_rate

      t.integer :level
      t.integer :experience
      t.string :growth_rate

      t.integer :hp
      t.integer :base_hp
      t.integer :attack
      t.integer :defense
      t.integer :special_attack
      t.integer :special_defense
      t.integer :speed

      t.references :trainer
      t.integer :slot
    end
  end
end
