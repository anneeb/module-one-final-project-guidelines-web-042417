class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :name
      t.integer :pokeballs, :default => 100
    end
  end
end
