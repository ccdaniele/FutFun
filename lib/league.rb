class League < ActiveRecord::Base

    has_many :clubs
    has_many :players, through: :clubs

    self.primary_key = "league_id"

    def self.all_league_names
        League.all
    end

    def self.find_league(league)
        League.find_by(name: league)
    end

    def self.populated_leagues
        League.all.select {|league| league.clubs.count > 0}
    end

    def clubs
        self.clubs.map do |club_a, club_b|
        end
    end

    def club_names
        self.clubs.map do |club| 
            puts club.name
        end
    end

    def league_clubs_stats
        self.clubs.each do |club|
            puts " #{club.name} "
            x = club.name.length
            puts "--".insert(0, "-" * x)
            puts " Wins: #{club.wins}"
            puts " Draws: #{club.draws}"
            puts " Losses: #{club.losses}"
            puts " Goals For: #{club.goals_for}"
            puts " Goals Against: #{club.goals_against}"
            puts " Clean Sheets: #{club.clean_sheets}"
            puts " Goals Denied: #{club.failed_to_score}"
            puts ""
            puts ""
        end
    end


    def calculate_standings
        clubs = {}
        self.clubs.each do |club|
            points = 0
            points += club.wins * 3
            points += club.draws * 1      
            clubs[club] = points
            
        end
        clubs.sort_by {|club, points| points}.reverse
        
    end


    def display_standings
        system "clear"
        self.each do |club, points|
            puts club.name
        end
    end



     def top_clubs   # needs method for order
        self.clubs.first(3)
     end
     
     def top_clubs_stats
        self.top_clubs.each {|club| puts club_stats }
     end

     
    
end


