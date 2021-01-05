class CreateSeasonsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons |t|
      t.integer :season
  end
end
