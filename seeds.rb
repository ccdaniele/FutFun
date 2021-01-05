require_relative 'config/environment.rb'
require 'pry'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'


def call_league
    url = URI("https://v3.football.api-sports.io/teams?league=39&season=2019")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'v3.football.api-sports.io'
    request["x-rapidapi-key"] = '8c78b34553ee9daa9b38805f456cdadb'

    response = http.request(request)
    y = JSON(response.read_body)
    y
end

def call_team
    url = URI("https://v3.football.api-sports.io/players?season=2018&league=39&team=#{n}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'v3.football.api-sports.io'
    request["x-rapidapi-key"] = '8c78b34553ee9daa9b38805f456cdadb'
    
    response = http.request(request)
    x = JSON(response.read_body)
    x
end

def create_player(n, club, call_team)
    x = call_team
    x["response"].map do |player|
        name = player["player"]["name"]
        nationality = player["player"]["Nationality"]
        club_id = club.id
        player = Player.create({name: name, nationality: nationality, club_id: club_id})
    end
end

def populate_league(call_league)
    x = call_league
    league = League.create(name: "EPL")

    x["response"].each do |team| 
        name = team["team"]["name"]
        country = team["team"]["country"]
        founded = team["team"]["founded"]
        league_id = league.id
        n = ["team"][0]["id"]
        club = Club.create(name: name, country: country, league_id: league_id)
        create_player(n, club, call_team)
    end
end

binding.pry  

