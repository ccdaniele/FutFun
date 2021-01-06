class Player < ActiveRecord::Base 
    
    self.primary_key = "player_id"
    
    belongs_to :club
    has_many :seasons
    has_many :player_stats
    has_many :player_stats, through: :seasons
    
end

