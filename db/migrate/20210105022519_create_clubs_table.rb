class CreateClubsTable < ActiveRecord::Migration[5.2]
  def change
    
    create_table :clubs, {id: false} do |t|
      t.integer :club_id
      t.string :name
      t.string :country
      t.integer :founded
      t.string :stadium
      t.string :city

    end
  end
end

