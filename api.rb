require_relative 'config/environment.rb'
require 'pry'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

                    
  #           <--------api methods------->


def call(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'v3.football.api-sports.io'
    request["x-rapidapi-key"] = '8c78b34553ee9daa9b38805f456cdadb'
    response = http.request(request)
    JSON(response.read_body)
end

def call_league
    call(URI("https://v3.football.api-sports.io/teams?league=39&season=2014"))
end

def call_league_by_id(id, season)
    call(URI("https://v3.football.api-sports.io/teams?league=#{id}&season=#{season}"))
end

def assign_leagues_seasons(league)

end
    
def create_league_across_seasons(league)
    season = 2011
    while season < 2019 do

        call_league_by_id(league)
        league.eason = season
    end


end

def call_custom_league(league, season)
    call(URI("https://v3.football.api-sports.io/teams?league=#{league}&season=#{season}"))
end

def call_team
    call(URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=50"))
end

def call_team_players(league, season, team)
    call(URI("https://v3.football.api-sports.io/players?season=#{season}&league=#{league}&team=#{team}"))
end

def call_player(id, season)
    call(URI("https://v3.football.api-sports.io/players?id=#{id}&season=#{season}"))
end

def call_team_stats(team, league, season)    #incomplete
    l = league_selection(league)
    t = team_selection(team)  #need team_selection method based on league
    call(URI("https://v3.football.api-sports.io/teams/statistics?league=#{l}&team=#{t}&season=#{season}"))
end

def call_club_ucl_record_by_name(season, club_name)
    club = find_a_club(club_name)
    id = club.club_id 
    call(URI("https://v3.football.api-sports.io/teams/statistics?season=#{season}&team=#{id}&league=2"))
end

def call_club_uel_record_by_name(season, club_name)
    club = find_a_club(club_name)
    id = club.club_id 
    call(URI("https://v3.football.api-sports.io/teams/statistics?season=#{season}&team=#{id}&league=3"))
end

def call_league_and_season(league, season)
    l = league_selection(league)
    url = URI("https://v3.football.api-sports.io/leagues?season=#{season}&id=#{l}")
    call(url)
end

  #           <--------database methods------->


league_array = [39, 140, 78, 61, 135, 253]
seasons = [2017, 2018, 2019]

def league_selection(league)
    if league == "EPL"
        l = 39
    elsif league == "140"
        league == "La Liga"
        l = 140
    elsif
        league == "Bundesliga"
        l = 78
    elsif 
        league == "Ligue 1"
        l = 61
    elsif
        league == "Serie A"
        l = 135
    elsif
        league == "MLS"
        l = 253
    elsif
        league == "Champions League"
        l = 2
    elsif
        league == "Europa League"
        l = 3
    end
    l
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

def find_a_club(club_name) 
    Club.find_by(name: "#{club_name}")
end


  #           <--------create methods-------> 

def destroy_all
    Club.destroy_all
    Player.destroy_all
    League.destroy_all
end

def create_leagues_ids        #populates with leagues, their ids and basic data
    url = URI("https://v3.football.api-sports.io/leagues?type=league")
    x = call(url)
    x["response"].each do |league|
        league_id = league["league"]["id"]
        name = league["league"]["name"]
        country = league["country"]["name"]
        stats_since = league["seasons"][0]["year"]
        League.find_or_create_by(league_id: league_id, name: name, country: country, stats_since: stats_since)
    end
end

def create_all(league_array, seasons)
    seasons.each do |year|
        season = year
        league_array.each do |table|
            league = table
                seed_league_teams_and_players(league, season)
        end
    end
end

def create_players_from_team(club, url)     #helper method for populate_league, below
    call(url)["response"].map do |player|
        name = player["player"]["name"]
        nationality = player["player"]["nationality"]
        player_id = player["player"]["id"]
        player = Player.find_or_create_by(player_id: player_id, name: name, nationality: nationality)
    end
end

def seed_league_teams_and_players(league, season)     #populates with a league, its teams with basic data, and their players' ids and basic data by season
    x = call_custom_league(league, season)
    x["response"].map do |team|
        club_id = team["team"]["id"]
        name = team["team"]["name"]
        country = team["team"]["country"]
        founded = team["team"]["founded"]
        stadium = team["venue"]["name"]
        city = team["venue"]["city"]
        new_club = Club.find_or_create_by(club_id: club_id, name: name, country: country, founded: founded, stadium: stadium, city: city)
        url = URI("https://v3.football.api-sports.io/players?season=#{season}&league=#{league}&team=#{club_id}")
        create_players_from_team(new_club, url)
    end
end

def create_clubs_ids_across_leagues(league_array, season)
    league_array.each do |league| league_id = league
        create_club_ids(league_id, season)
    end
end

def create_clubs_ids_across_seasons_and_leagues(league_array, seasons)
    seasons.each do |season|
        create_clubs_ids_across_leagues(league_id, season)
    end
end  

def create_player_ids
    x = call_team   #manchester city 2019
    x["response"].map do |player|
        name = player["player"]["name"]
        nationality = player["player"]["nationality"]
        player_id = player["player"]["id"]
            Player.find_or_create_by(player_id: player_id, name: name, nationality: nationality)
    end
end

def create_player_ids_across_league_for_a_season(league, season)
    x = call_custom_league(league, season)
    x["response"].each do |club|
        team = club["team"]["id"]
        players = call_team_players(league, season, team)
        players["response"].each do |player|
            name = player["player"]["name"]
            nationality = player["player"]["nationality"]
            player_id = player["player"]["id"]
              Player.find_or_create_by(player_id: player_id, name: name, nationality: nationality)
        end
    end
end

def create_player_ids_across_season_for_array_of_leagues(league_array, season)
    league_array.each do |league| 
        create_player_ids_across_league_for_a_season(league, season)
    end
end

def player_season(player_id, season)         #broken
    player_stats = call_player(player_id, season)
    player_id = player_stats["parameters"]["id"]
    season = player_stats["parameters"]["season"]
    if !Player.find_by(player_id: "{player_id}", seasons: "#{season}")
        new_player = Player.create(player_id: "#{player_id}", seasons: "#{season}")
    end

    binding.pry
    name = player_stats["response"][0]["player"]["name"]
    club_id = player_stats["response"][0]["statistics"][0]["team"]["id"]
    age = player_stats["response"][0]["player"]["age"]
    height = player_stats["response"][0]["player"]["height"]
    weight = player_stats["response"][0]["player"]["weight"]
    appearances =  player_stats["response"][0]["statistics"][0]["games"]["appearences"]
    minutes =  player_stats["response"][0]["statistics"][0]["games"]["minutes"]
    position =  player_stats["response"][0]["statistics"][0]["games"]["position"]
    rating =  player_stats["response"][0]["statistics"][0]["games"]["rating"]
    shots =  player_stats["response"][0]["statistics"][0]["shots"]["total"]
    shots_on_target =  player_stats["response"][0]["statistics"][0]["shots"]["on"]
    goals =  player_stats["response"][0]["statistics"][0]["goals"]["total"]
    goals_conceded =  player_stats["response"][0]["statistics"][0]["goals"]["conceded"]
    goals_saved =  player_stats["response"][0]["statistics"][0]["goals"]["saves"]
    assists =  player_stats["response"][0]["statistics"][0]["goals"]["assists"]
    passes =  player_stats["response"][0]["statistics"][0]["passes"]["total"]
    pass_accuracy =  player_stats["response"][0]["statistics"][0]["passes"]["accuracy"]
    tackles =  player_stats["response"][0]["statistics"][0]["tackles"]["total"]
    blocks =  player_stats["response"][0]["statistics"][0]["tackles"]["blocks"]
    interceptions =  player_stats["response"][0]["statistics"][0]["tackles"]["interceptions"]
    duels =  player_stats["response"][0]["statistics"][0]["duels"]["total"]
    duels_won =  player_stats["response"][0]["statistics"][0]["duels"]["won"]
    dribbles_attempted =  player_stats["response"][0]["statistics"][0]["dribbles"]["attempts"]
    dribbles_successful =  player_stats["response"][0]["statistics"][0]["dribbles"]["success"]
    fouls_drawn =  player_stats["response"][0]["statistics"][0]["fouls"]["drawn"]
    fouls_committed =  player_stats["response"][0]["statistics"][0]["fouls"]["committed"]
    yellow_cards =  player_stats["response"][0]["statistics"][0]["cards"]["yellow"]
    red_cards =  player_stats["response"][0]["statistics"][0]["cards"]["red"]
    penalties_won =  player_stats["response"][0]["statistics"][0]["penalty"]["won"]
    penalties_committed =  player_stats["response"][0]["statistics"][0]["penalty"]["committed"]
    penalties_scored =  player_stats["response"][0]["statistics"][0]["penalty"]["scored"]
    penalties_missed =  player_stats["response"][0]["statistics"][0]["penalty"]["missed"]
    penalties_saved =  player_stats["response"][0]["statistics"][0]["penalty"]["saved"]
    PlayerStats.create(player_id: "#{player_id}", season: "#{season}", name: "#{name}", club_id: "#{club_id}", age: "#{age}", height: "#{height}", weight: "#{weight}", appearances: "#{appearances}", minutes: "#{minutes}", position: "#{position}", rating: "#{rating}", shots: "#{shots}", shots_on_target: "#{shots_on_target}", goals: "#{goals}", goals_conceded: "#{goals_conceded}", goals_saved: "#{goals_saved}", assists: "#{assists}", passes: "#{passes}", pass_accuracy: "#{pass_accuracy}", tackles: "#{tackles}", blocks: "#{blocks}", interceptions: "#{interceptions}", duels: "#{duels}", duels_won: "#{duels_won}", dribbles_attempted: "#{dribbles_attempted}", dribbles_successful: "#{dribbles_successful}", fouls_drawn: "#{fouls_drawn}", fouls_committed: "#{fouls_committed}", yellow_cards: "#{yellow_cards}", red_cards: "#{red_cards}", penalties_won: "#{penalties_won}", penalties_committed: "#{penalties_committed}", penalties_scored: "#{penalties_scored}", penalties_missed: "#{penalties_missed}", penalties_saved: "#{penalties_saved}")
    end

    def create_seasons
        year = 2011
        while year < 2019 do
        season = Season.create(season: "#{year}")
        year += 1
        end
    end
 

binding.pry