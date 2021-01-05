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
    request["x-rapidapi-key"] = '8b937051139da77bba6b2a445b095d62'
    response = http.request(request)
    JSON(response.read_body)
end

def call_league
    url = URI("https://v3.football.api-sports.io/teams?league=39&season=2019")
    call(url)
end

def call_team
    url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
    call(url)
end

def find_or_create_club(club)
end

def create_player(club, url)
        call(url)["response"].map do |player|
        name = player["player"]["name"]
        nationality = player["player"]["Nationality"]
        club_id = club.id
        player = Player.create({name: name, nationality: nationality, club_id: club_id})
    end
end

def populate_league
    league = League.create(name: "EPL")
    call_league["response"].map do |team|   
        name = team["team"]["name"]
        country = team["team"]["country"]
        founded = team["team"]["founded"]
        league_id = league.id
        n = team["team"]["id"]
        club = Club.create(name: name, country: country, league_id: league_id)
        url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=#{n}")
        create_player(club, url)
    end
end


binding.pry  