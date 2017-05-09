class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.text :name
      t.integer :pokeballs
      t.integer :games_played
    end
  end
end
