class AddPlayersColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :number, :integer
    add_column :players, :goals_conceded, :integer
    add_column :players, :goals_saved, :integer
    add_column :players, :passes, :integer
    add_column :players, :pass_accuracy, :float
    add_column :players, :season, :integer
  end
end

