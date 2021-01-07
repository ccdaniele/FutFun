class League < ActiveRecord::Base

    has_many :clubs
    has_many :players, through: :clubs

    self.primary_key = "league_id"

    def self.clubs(league)
        League.find(league).clubs.map do |club_a, club_b|
            binding.pry
             club_a.name <=> club_b.name
        end
    end

    def self.club_names(league)
        League.find(league).clubs.map do |club| 
            club.name
        end
    end

    def self.league_clubs_stats(league_id)
        League.find(league).clubs.each do |club|
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

    def self.calculate_standings(league_id)
        clubs = {}
        League.find(league_id).clubs.each do |club|
            points = 0
            points += club.wins * 3
            points += club.draws * 1      
            clubs[club] = points
            
        end
        clubs.sort_by {|club, points| points}.reverse
        
    end

    def self.display_standings(league)
        system "clear"
        table = League.calculate_standings(league)
        table.each do |club, points|
            puts club.name
        end
    end

     def self.top_teams(league)
        League.calculate_standings(league).first(3)
     end
     
     def self.top_teams_stats(league)
        League.top_teams(league).each do 

        end
     end

    

end

