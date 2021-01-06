require_relative 'config/environment.rb'
require 'pry'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'


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

                    
  #           <--------api methods------->



def call_player(id)
    url = URI("https://v3.football.api-sports.io/players?id=#{id}&season=2018")
    call(url)
end

def call_league
    url = URI("https://v3.football.api-sports.io/teams?league=39&season=2019")
    call(url)
end

def call_team
    url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
    call(url)
end

def call_club_season_record(season, team)
    url = URI("https://v3.football.api-sports.io/teams/statistics?season=2019&team=33&league=39") #epl
    url = URI("https://v3.football.api-sports.io/teams/statistics?season=2019&team=33&league=39") #liga
    call(url)
end

def call_league_and_season(league, season)
    l = league_selection(league)
    url = URI("https://v3.football.api-sports.io/leagues?season=#{season}&id=#{l}")
    call(url)
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

def populate_league
    league = League.create(name: "EPL")
    call_league["response"].map do |team|   
        name = team["team"]["name"]
        country = team["team"]["country"]
        founded = team["team"]["founded"]
        league_id = 
        n = team["team"]["id"]
        club = Club.create(name: name, country: country, league_id: league_id)
        url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
        create_player(club, url)
    end
end

def find_or_create_season_and_league(season, league)
url = URI("https://v3.football.api-sports.io/leagues?season=#{season}&id=#{league}")

end

def top_scorers
    require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://v3.football.api-sports.io/players/topscorers?season=2019&league=61")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-host"] = 'v3.football.api-sports.io'
request["x-rapidapi-key"] = '8b937051139da77bba6b2a445b095d62'

response = http.request(request)
x = JSON(response.read_body)
end



  #           <--------database methods------->



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

binding.pry  


##populate seasons with leagues

def seasons
    
end