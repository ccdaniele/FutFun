class CreateLeaguesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues, {id: false} do |t|
      t.integer :league_id
      t.string :name
      t.string :country
      t.integer :stats_since
    end
  end
end


