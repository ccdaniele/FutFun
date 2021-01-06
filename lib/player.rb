class Player < ActiveRecord::Base 
    belongs_to :club

    self.primary_key = "player_id"
end
