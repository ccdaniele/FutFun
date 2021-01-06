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

def call_custom_league(league, season)
    call(URI("https://v3.football.api-sports.io/teams?league=#{league}&season=#{season}"))
end

def call_team
    call(URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=50"))
end

def call_team_players(season, league, team)
    call(URI("https://v3.football.api-sports.io/players?season=#{season}&league=#{league}&team=#{team}"))
end

def call_player(id)
    call(URI("https://v3.football.api-sports.io/players?id=#{id}&season=2018"))
end

def call_clubs_in_a_league(league, season)
    call(URI("https://v3.football.api-sports.io/teams?league=#{league}&season=#{season}"))
end

def call_team_stats(team, league, season)    #incomplete
    l = league_selection(league)
    t = team_selection(team)  #need team_selection method based on league
    call(URI("https://v3.football.api-sports.io/teams/statistics?league=#{l}&team=#{t}&season=#{season}"))
end

def call_club_ucl_record(season, club_name)   #needs to be tested
    club = find_a_club(club_name)
    id = club.club_id 
    call(URI("https://v3.football.api-sports.io/teams/statistics?season=#{season}&team=#{id}&league=2"))
end

def call_club_uel_record(season, club)   #needs team_selection and error for teams not in uel
    call(URI("https://v3.football.api-sports.io/teams/statistics?season=#{season}&team=#{club}&league=3"))
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


def create_player(club, url)
    url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=50")
    call(url)["response"].map do |player|
        name = player["player"]["name"]
        nationality = player["player"]["nationality"]
        player_id = player["player"]["id"]
        age = player["player"]["age"]
        #club_id = club.id
        player = Player.create(player_id: player_id, name: name, nationality: nationality) #, club_id: club_id}
    end
end

def populate_league(league, season)
    x = call_custom_league(league, season)
    x["response"].map do |team|
        club_id = team["team"]["id"]   
        name = team["team"]["name"]
        country = team["team"]["country"]
        founded = team["team"]["founded"]
        n = team["team"]["id"]
        club = Club.create(club_id: club_id, name: name, country: country, founded: founded)
        # url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
        # create_player(club, url)
    end
end

def find_or_create_season_and_league(season, league)    #incomplete
    url = URI("https://v3.football.api-sports.io/leagues?season=#{season}&id=#{league}")
end

def create_club_ids(league, season)
    x = call_clubs_in_a_league(league, season)
    x["response"].each do |team|
        club_id = team["team"]["id"]
        name = team["team"]["name"]
        country = team["team"]["country"]
        founded = team["team"]["founded"]
        stadium = team["venue"]["name"]
        city = team["venue"]["city"]
        new_club = Club.create(club_id: club_id, name: name, country: country, founded: founded, stadium: stadium, city: city)
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
        if !Player.find(player_id)
            player = Player.create(player_id: player_id, name: name, nationality: nationality)
        else 
            "Already registered player!"
        end
    end
end

def create_player_ids_across_league(league, season)
    x = call_team_players(season, league, team)
end

def create_leagues_ids
    url = URI("https://v3.football.api-sports.io/leagues?type=league")
    x = call(url)
    x["response"].each do |league|
        league_id = league["league"]["id"]
        name = league["league"]["name"]
        country = league["country"]["name"]
        stats_since = league["seasons"][0]["year"]
        if !League.find(league_id)
            new_league = League.create(league_id: league_id, name: name, country: country, stats_since: stats_since)
        else
            "Already a league!"
        end
    end
    
end

def seed_database_with_ids
    create_leagues_ids
    create_clubs_ids_across_seasons_and_leagues(league_array, seasons)
    #create_player_ids
end


binding.pry