class Club < ActiveRecord::Base
    has_many :players
    belongs_to :league
    
    self.primary_key = "club_id"

    def self.club_info(club)
        club = self.find_by(name: club)
        
        system "clear"
        
        puts "Name: #{club.name}"
        puts ""
        puts "Country: #{club.country}"
        puts ""
        puts "City: #{club.city}"
        puts ""
        puts "Stadium: #{club.stadium}"
        puts ""
        
    end

    def self.club_stats(club)
        club = Club.find_by(name: club)
 
        system "clear"

        puts "#{club.name} "
        puts ""
        puts "  2019 Season Form  " 
        puts "------------------- "
        puts ""
        puts " Games Played:   #{club.played} "
        puts " Wins:           #{club.wins} "
        puts " Draws:          #{club.draws} "
        puts " Losses:         #{club.losses} " 
        puts " Goals For:      #{club.goals_for} " 
        puts " Goals Against:  #{club.goals_against} "
        puts " Clean Sheets:   #{club.clean_sheets} "
        puts " No Goals:       #{club.failed_to_score} "
        puts ""
    end

    def club_stats(club)
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

    def self.club_roster(club)
        club = Club.find_by(name: club)
        club.players
    end

    

end