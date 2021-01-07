class Player < ActiveRecord::Base 
    
    self.primary_key = "player_id"
    
    belongs_to :club
    

end

