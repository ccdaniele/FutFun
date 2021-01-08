class Club < ActiveRecord::Base
    has_many :players
    belongs_to :league
    
    self.primary_key = "club_id"

    def self.find_club_by_name(name)
        Club.all.find_by(name: name)
    end

    def self.club_name_from_id(club_id)
        Club.find_by(club_id: club_id).name
    end

    def club_info
        system "clear"
        header_footer
        line_formatting(25)
        puts ""
        puts "Name: #{self.name}"
        puts ""
        puts "Country: #{self.country}"
        puts ""
        puts "City: #{self.city}"
        puts ""
        puts "Stadium: #{self.stadium}"
        puts ""
        line_formatting(25)
        header_footer
    end

    def club_data

        system "clear"

        space_formatting(self.name, 18)
        space_formatting("2019 Season Form", 18) 
        line_formatting(18)
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
        header_footer
        space_formatting("2019", 18)
        space_formatting(self.name, 18)
        line_formatting(18)
        puts " Wins: #{self.wins}"
        puts " Draws: #{self.draws}"
        puts " Losses: #{self.losses}"
        puts " Goals For: #{self.goals_for}"
        puts " Goals Against: #{self.goals_against}"
        puts " Clean Sheets: #{self.clean_sheets}"
        puts " Goals Denied: #{self.failed_to_score}"
        line_formatting(18)
        header_footer
    end

    def roster
        self.players
    end

    def roster_names
        self.players.each {|player| puts player.name}
    end
    
    def club_red_cards   #helper method for #most_red_cards in League
        cards = 0
        self.players.each do |player|
            if !player.red_cards
                player.red_cards = 0
            end
            cards += player.red_cards    
        end
        cards
    end

    def club_minutes     #helper method for #most_minutes in League
        player_minutes = {}
        self.players.each do |player|
            if !player.minutes
                player.minutes = 0
            end
             += player.data     
        end
        variable
    end

    def club_ratings
        player_ratings = {}
        self.players.each do |player|
            if !player.rating
                player.rating = 5
            end
            player_ratings[player.name] = player.rating
        end
        player_ratings
    end

    def self.highest_rated
        club_rating = {}
        Club.all.each do |club|
            ratings = club.club_ratings
            average = (sum_rating(ratings) / club.players.count)
            club_rating[club.name] = average
        end
        club_rating.sort_by{|club, rating| rating}.reverse

    end

    def player_goal_percentage #not done!
        player_hash = {}
        player_average_hash = {}
        club_goals = self.goals_for
        self.players.each do |player|
            player_hash[player.name] = player.goals 
        end
        player_hash.map {|player, goals| player_average_hash[player] = goals/club_goals}
    end
end

def sum_rating(hash)
    sum = 0
    players = 0
    hash.each {|x, y| sum += y }
    sum 
end

#------- For Formatting ------

def dependent_line_formatting(type)
    x = type.length
    puts "--".insert(0, "-" * x)
end

def line_formatting(spaces)
    puts "--".insert(0, "-" *spaces)
end

def space_formatting(type, spaces)
    x = (spaces - type.length) / 2
    puts type.insert(0, " "* x)
end

def header_footer
    puts ""
    puts ""
end