class CreatePlayersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :players, {id: false} do |t|
      t.integer :player_id
      t.integer :club_id
      t.string :name
      t.string :nationality
    end
  end
end

# t.string :name
# t.integer :age
# t.string :nationality
# t.integer :height
# t.integer :weight
# t.integer :club_id
# t.integer :appearances
# t.integer :minutes
# t.string :position
# t.float :rating
# t.integer :shots
# t.integer :shots_on_target
# t.integer :goals
# t.integer :assists
# t.integer :tackles
# t.integer :blocks
# t.integer :interceptions
# t.integer :duels
# t.integer :duels_won
# t.integer :dribbles_attempted
# t.integer :dribbles_successful
# t.integer :fouls_drawn
# t.integer :fouls_committed
# t.integer :yellow_cards
# t.integer :red_cards
# t.integer :penalties_won
# t.integer :penalties_committed
# t.integer :penalties_scored
# t.integer :penalties_missed
# t.integer :penalties_saved