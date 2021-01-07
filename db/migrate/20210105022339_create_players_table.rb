class CreatePlayersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :players, {id: false} do |t|
      t.integer :player_id
      t.string :name
      t.string :nationality
    end
  end
end
