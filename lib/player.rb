class Player < ActiveRecord::Base 
    self.primary_key = "player_id"
    
    belongs_to :club
    
    def self.find_player(name) 
        x = Player.all.find(name: name)
    end

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
binding.pry

end

