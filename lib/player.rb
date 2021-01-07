class Player < ActiveRecord::Base 
    
    self.primary_key = "player_id"
    
    belongs_to :club
    has_many :users
    
    def self.find_by_name(name)
        self.find_by(name: name)
    end

    # def self.top_10_goal_scores
    #     player_hash = {}
    #     self.all.each do |player_instance|
        
    #         player_hash[player_instance.name] = player_instance.goals
    #     end 
    #     player_hash
    
    #     binding.pry
    # end

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



