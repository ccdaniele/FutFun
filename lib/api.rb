require_relative 'config/environment.rb'
require 'pry'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class Api

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

def call_league    #epl, 2019
    url = URI("https://v3.football.api-sports.io/teams?league=39&season=2019")
    call(url)
end

def call_team    #2019
    url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
    call(url)
end

def epl_by_season(season)
    url = URI("https://v3.football.api-sports.io/teams?league=39&season=#{season}")
    call(url)
end

def create_player(club, url)
        call(url)["response"].map do |player|
        name = player["player"]["name"]
        nationality = player["player"]["nationality"]
        #number = ["statistics"][0]["games"]["number"]
        # position = ["statistics"][0]["games"]["position"]
        club_id = club.id
        # age = player["player"]["age"]
        player = Player.create(name: name, nationality: nationality, club_id: club_id)
    end
end

def populate_league(season)    #league, season
    league = League.create(name: "EPL")
    x = epl_by_season(season)
    x["response"].map do |club|   
        name = club["team"]["name"]
        country = club["team"]["country"]
        founded = club["team"]["founded"]
        league_id = league.id
        n = club["team"]["id"]
        new_club = Club.create(name: name, country: country, league_id: league_id)
        url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
        create_player(new_club, url)
    end
end
end 

binding.pry  