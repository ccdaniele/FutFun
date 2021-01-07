class Club < ActiveRecord::Base
    has_many :players
    belongs_to :league
    
    self.primary_key = "club_id"

    def initialize()

    end

    def club_info
        system "clear"
        
        puts "Name: #{self.name}"
        puts ""
        puts "Country: #{self.country}"
        puts ""
        puts "City: #{self.city}"
        puts ""
        puts "Stadium: #{self.stadium}"
        puts ""
        
    end

    def club_data

        system "clear"

        puts "#{self.name} "
        puts ""
        puts "  2019 Season Form  " 
        puts "------------------- "
        puts ""
        puts " Games Played:   #{self.played} "
        puts " Wins:           #{self.wins} "
        puts " Draws:          #{self.draws} "
        puts " Losses:         #{self.losses} " 
        puts " Goals For:      #{self.goals_for} " 
        puts " Goals Against:  #{self.goals_against} "
        puts " Clean Sheets:   #{self.clean_sheets} "
        puts " No Goals:       #{self.failed_to_score} "
        puts ""
    end

    def club_stats
        x = self.name.length
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

    def roster
        self.players
    end

    def roster_names
        self.players.each {|player| puts player.name}
    end
 

end