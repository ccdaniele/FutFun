class UsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :favorite_clubs
      t.string :favorite_players
      t.string :favorite_leagues
    end
  end
end
