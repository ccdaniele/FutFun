class Player < ActiveRecord::Base 
    
    self.primary_key = "player_id"
    
    belongs_to :club
    has_many :player_stats
    Player.all
end

binding.pry
