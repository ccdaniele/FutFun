class Player < ActiveRecord::Base 
    self.primary_key = "player_id"
    
    belongs_to :club
    has_many :users
    
    def self.find_by_name(name)
        self.find_by(name: name)
    end

<<<<<<< HEAD
=======

    def self.top_goals
        players = {}
        Player.all.each do |player|
            if !player.goals
                player.goals = 0
            end
            players[player.name] = player.goals
        end
        players.sort_by {|player, goals| goals}.reverse.first(10)
        
    end
#binding.pry

end

def self.top_goalkeeper
    players = {}
    Player.all.each do |player|
        if !player.goals
            player.goals = 0
        end
        players[player.name] = player.goals
    end
    players.sort_by {|player, goals| goals}.reverse.first(10)
    
end
#binding.pry
>>>>>>> 06762331f8352db3cab24dd0db62f28b605390d0

end



