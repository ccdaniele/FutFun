class CreateClubsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :club do |t|
      t.string :name
      t.integer :league_id
      t.integer :season
      t.string :country
    end
  end
end
