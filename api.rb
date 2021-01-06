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
    call(URI("https://v3.football.api-sports.io/teams?league=39&season=2019"))
end

def call_team
    call(URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}"))
end

def call_player(id)
    call(URI("https://v3.football.api-sports.io/players?id=#{id}&season=2018"))
end

def call_clubs_in_a_league(league, season)
    l = league_selection(league)
    call(URI("https://v3.football.api-sports.io/teams?league=#{l}&season=#{season}"))
end

def call_team_stats(team, league, season)    #incomplete
    l = league_selection(league)
    t = team_selection(team)  #need team_selection method based on league
    call(URI("https://v3.football.api-sports.io/teams/statistics?league=#{l}&team=#{t}&season=#{season}"))
end

def call_club_ucl_record(season, club)   #needs team_selection and error for teams not in ucl
    call(URI("https://v3.football.api-sports.io/teams/statistics?season=#{season}&team=#{club}&league=2"))
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


basic_league_array = [39, 140, 78, 61, 135, 253]

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

def find_a_club(name) 
    Club.find_by(name: "#{name}")
end


  #           <--------create methods-------> 


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

def populate_league   #add league array parameter
    call_league["response"].map do |team|   
        name = team["team"]["name"]
        country = team["team"]["country"]
        founded = team["team"]["founded"]
        #league_id = 
        n = team["team"]["id"]
        club = Club.create(name: name, country: country, league_id: league_id)
        url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
        create_player(club, url)
    end
end

def find_or_create_season_and_league(season, league)    #incomplete
    url = URI("https://v3.football.api-sports.io/leagues?season=#{season}&id=#{league}")
end

def create_club_identities_in_league_by_season(league, season)
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

def create_player_ids
end

def create_leagues_ids
    url = URI("https://v3.football.api-sports.io/leagues?type=league")
    x = call(url)
    x["response"].each do |league|
        league_id = league["league"]["id"]
        name = league["league"]["name"]
        country = league["country"]["name"]
        stats_since = league["seasons"][0]["year"]
        new_league = League.create(league_id: league_id, name: name, country: country, stats_since: stats_since)
    end
    
end

def seed_database_with_ids
    create_leagues_ids
    create_team_identities_by_season(league, season)
    create_player_ids
end


binding.pry