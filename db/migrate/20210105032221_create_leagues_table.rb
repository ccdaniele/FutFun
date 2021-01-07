class CreateLeaguesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues, {id: false} do |t|
      t.integer :league_id
      t.integer :season
      t.string :name
      t.string :country
    end
  end
end

