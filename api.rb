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

def create_player(club, url)
        url = URI("https://v3.football.api-sports.io/players?season=2019&league=39&team=50")
        call(url)["response"].map do |player|
        name = player["player"]["name"]
        nationality = player["player"]["nationality"]
        player_id = player["player"]["id"]
        age = player["player"]["age"]
        club_id = club.id
        player = Player.create({name: name, nationality: nationality, player_id: player_id, club_id: club_id})
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