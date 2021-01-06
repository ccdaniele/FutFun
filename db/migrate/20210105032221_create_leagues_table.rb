class CreateLeaguesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :league_id
    end
  end
end
