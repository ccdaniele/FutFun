class CreateClubsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs, {id: false} do |t|
      t.integer :club_id
      t.string :name
      t.integer :league_id
      t.integer :player_id
      t.integer :season
      t.string :country
      t.integer :founded
    end
  end
end
