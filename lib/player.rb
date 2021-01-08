class Player < ActiveRecord::Base 
    self.primary_key = "player_id"
    
    belongs_to :club
    has_many :users
    
    def self.find_by_name(name)
        self.find_by(name: name)
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

    def self.top_goalkeeper
        players = {}
        Player.all.each do |player|
            if !player.goals_saved
                player.goals_saved= 0
            end
            players[player.name] = player.goals_saved
        end
        players.sort_by {|player, goals_saved| goals_saved}.reverse.first(10)
        
    end
    
    def self.top_defense
        players = {}
        Player.all.each do |player|
            if !player.blocks
                player.blocks= 0
                !player.tackles
                  player.tackles= 0
                !player.interceptions
                  player.interceptions= 0      
   
            end
            defense_points = (player.blocks + player.tackles + player.tackles)/2
            players[player.name] = defense_points
            #binding.pry
        end
        players.sort_by {|player, defense_points| defense_points}.reverse.first(10)
      
    end
    #binding.pry

    def self.top_defense
        players = {}
        Player.all.each do |player|
            if !player.blocks
                player.blocks= 0
            end
             if !player.tackles
                  player.tackles= 0
             end
            if !player.interceptions
                  player.interceptions= 0      
                  
            end
            defense_points = (player.blocks + player.interceptions + player.tackles)/3
            players[player.name] = defense_points
            #binding.pry
        end
        players.sort_by {|player, defense_points| defense_points}.reverse.first(10)
      
    end
    #binding.pry
    
    def self.top_danger
        players = {}
        Player.all.each do |player|
            if !player.yellow_cards
                  player.yellow_cards= 0
            end
            if !player.red_cards
                  player.red_cards= 0
            end
            if !player.fouls_committed
                  player.fouls_committed= 0        
            end
            danger_points = (player.yellow_cards + player.red_cards + player.fouls_committed)/3
            players[player.name] = danger_points
            #binding.pry
        end
        players.sort_by {|player, danger_points| danger_points}.reverse.first(10)
      
    end
    #binding.pry
    














end
#binding.pry





