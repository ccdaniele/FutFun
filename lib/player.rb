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
                player.blocks = 0
            end
             if !player.tackles
                  player.tackles = 0
             end
            if !player.interceptions
                  player.interceptions = 0    
            end
            defense_points = (player.blocks + player.interceptions + player.tackles)/3
            players[player.name] = defense_points
        end
        players.sort_by {|player, defense_points| defense_points}.reverse.first(10)
      
    end

    
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
            danger_points = (player.yellow_cards*2 + player.red_cards*4 + player.fouls_committed)/3
            players[player.name] = danger_points
            #binding.pry
        end
        players.sort_by {|player, danger_points| danger_points}.reverse.first(10)
    end

    def player_info
        club = Club.club_name_from_id(self.club_id)
        header_footer
        line_formatting(22)
        puts "Name: #{self.name}"
        puts "Position: #{position}"
        puts "Club: #{club}"
        puts "Age: #{self.age}"
        puts "Height: #{self.height}"
        puts "Weight: #{self.weight}"
        line_formatting(22)
        header_footer
    end

    def player_stats        
        club = Club.club_name_from_id(self.club_id)
        header_footer
        line_formatting(22)
        puts "Name: #{self.name}"
        puts "Club: #{club}"
        puts "Rating: #{rating}"
        puts "Appearances: #{self.appearances}"
        puts "Minutes Played: #{self.minutes}"
        if self.position == "Goalkeeper"
            self.goalkeeper_stats
        else
            self.field_player_stats
        end   
        line_formatting(22)
        header_footer
    end

    def field_player_stats
        puts "Shots: #{self.shots}"
        puts "Shots on Target: #{self.shots_on_target}"
        puts "Goals: #{self.goals}"
        puts "Assists: #{self.assists}"
        puts "Passes: #{self.passes}"
        puts "Tackles: #{self.tackles}"
        puts "Interceptions: #{self.interceptions}"
        puts "Duels: #{self.duels}"
        puts "Duels Won: #{self.duels_won}"
        puts "Dribbles Attempted: #{self.dribbles_attempted}"
        puts "Successful Dribbles: #{self.dribbles_successful}"
        puts "Fouls Drawn: #{self.fouls_drawn}"
        puts "Fouls Committed: #{self.fouls_committed}"
        puts "Penalties Won: #{self.penalties_won}"
        puts "Penalties Committed: #{self.penalties_committed}"
        puts "Penalties Scored: #{self.penalties_scored}"
        puts "Penalties Missed: #{self.penalties_missed}"
        puts "Yellow Cards: #{self.yellow_cards}"
        puts "Red Cards: #{self.red_cards}"
    end

    def goalkeeper_stats
        puts "Goals Conceded: #{self.goals_conceded}"
        puts "Goals Saved: #{self.goals_saved}"
        puts "Penalties Committed: #{self.penalties_committed}"
        puts "Penalties Saved: #{self.penalties_saved}"
        puts "Yellow Cards: #{self.yellow_cards}"
        puts "Red Cards: #{self.red_cards}"
    end

    def goals_by_minutes
        self.minutes / self.goals
    end

    def self.highest_ratings
        rating_hash = {}
        Player.all.each do |player|
            if !player.rating 
                player.rating = 0
            end
            rating_hash[player.name] = player.rating
        end
        rating_hash.sort_by{|player, rating| rating}.reverse.first(10)
    end

end

def find_a_players_team_by_name(player) 
    if Player.find_by(name: "#{player}")
        Player.find_by(name: "#{player}").club.name
    else
        puts "Sorry, we cannot find your player!"
    end
end

def find_a_player_by_name(name)
    id = Player.find_by(name: "#{name}").player_id
    call_player(id)
end





