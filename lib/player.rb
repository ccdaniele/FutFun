class Player < ActiveRecord::Base 
    self.primary_key = "player_id"
    
    belongs_to :club
    
    def self.find_player(name) 
        x = Player.all.find(name: name)
    end


end

