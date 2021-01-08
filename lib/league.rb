class League < ActiveRecord::Base

    has_many :clubs
    has_many :players, through: :clubs

    self.primary_key = "league_id"

    def self.all_league_names
        League.all.each {|league| puts league.name}
    end

    def self.find_league(league)
        League.find_by(name: league)
    end

    def club_names
        x = self.clubs.map do |club| 
            club.name
        end
        header_footer
        puts x
        header_footer
    end

    def league_clubs_stats      #FIX
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
            header_footer
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
        calculate_standings.each do |club, points|
            puts club.name
        end
    end

    def top_clubs   # broken for some reason
        puts "The league leaders were:"
        x = calculate_standings.first(3)
        x.each do |club| 
            puts club.name
        end
     end
     
    def top_clubs_stats
        self.top_clubs.each {|club| puts club_stats}
    end

    def self.most_goals
        league_goals = {}
        League.all.each do |league|
            goals = 0
            league.clubs.each do |club|
                goals += club.goals_for
            end
            league_goals[league.name] = goals
        end
        x = league_goals.sort_by {|team, goals| goals}.reverse.flatten
        x
    end

    def self.display_most_goals
        x = League.most_goals
        system "clear"
        header_footer
        header_footer
        puts "It looks like #{x[0]} saw the most action last year with #{x[1]} goals! Beat it, #{x[10]}, with your lethargic #{x[11]} goals!"
        header_footer
    end 

    def self.most_red_cards
        league_reds = {}
        League.all.each do |league|
            league_red_cards = 0
            league.clubs.each do |club|
                league_red_cards += club.club_red_cards
            end
            league_reds[league.name] = league_red_cards
        end 
        x = league_reds.sort_by {|team, reds| reds}.reverse.flatten
    end

    def self.display_most_red_cards
        x = League.most_red_cards
        header_footer
        header_footer
        puts "Watch out for #{x[0]}: with #{x[1]} red cards, the players in that league don't mess around! But look at the nice guys in #{x[10]}! They're proof that good, clean fun isn't had by playing dirty."
        header_footer
    end
     
    def self.most_clean_sheets
        league_clean_sheets = {}
        League.all.each do |league|
            clean_sheets = 0
            league.clubs.each do |club|
                clean_sheets += club.club_specific_data(clean_sheets) 
            end
            league_clean_sheets[league.name] = clean_sheets
        end 
        x = league_clean_sheets.sort_by {|team, cs| cs}.reverse.flatten
    end
    
    def self.display_most_clean_sheets
        x = League.most_clean_sheets
        header_footer
        header_footer
        puts "It looks like #{x[0]} had the most clean sheets with #{x[1]}--they really have the cleanest sheets!"
        header_footer
    end

    def highest_goal_contribution_percentage
        x = self.clubs.map {|club| club.player_goal_percentage}
    end

    def most_minutes_in_league   #player with most minutes played for each team in league
        player_minutes = {}
        club_player = {}
        self.clubs.all.each do |club|
            n = 0
            x = club.club_minutes
            club_player[club.name] = {x[0] => x[1]}
            n += 1
        end
        club_player
    end

    def display_most_minutes
        club_player.each do |player, minutes|
            binding.pry
            puts "#{player}:"
            puts "#{minutes} minutes played"
        end
    end

    def display_most_minutes
        self.most_minutes_in_league.map do |team, players_minutes|
        end
    end

end


