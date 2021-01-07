class CreateClubsTable < ActiveRecord::Migration[5.2]
  def change
    
    create_table :clubs, {id: false} do |t|
      t.integer :club_id
      t.string :name
      t.string :country
      t.integer :founded
      t.string :stadium
      t.string :city
      t.integer :league_id
      t.string :form
      t.integer :played
      t.integer :wins
      t.integer :draws
      t.integer :losses
      t.integer :goals_for
      t.integer :goals_against
      t.integer :clean_sheets
      t.integer :failed_to_score
      
    end
  end
end

