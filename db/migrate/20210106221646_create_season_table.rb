class CreateSeasonTable < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons, primary_key: [:season] do |t|
      t.integer :season
    end
  end
end
