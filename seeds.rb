require 'pry'
require 'pry'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

url = URI("https://v3.football.api-sports.io/players?season=2018&league=39&team=50")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-host"] = 'v3.football.api-sports.io'
request["x-rapidapi-key"] = '8c78b34553ee9daa9b38805f456cdadb'

response = http.request(request)
y = JSON(response.read_body)


y["response"].each do |stat|
    name =  stat["player"]["name"]
    age =  stat["player"]["age"]
    nationality =  stat["player"]["Nationality"]
    height =  stat["player"]["height"]
    weight =  stat["player"]["weight"]
    club = ["statistics"][0]["team"]["name"]

    player = Player.create(name: name, age: age, nationality: nationality)
end




      season = 
#     appearances = ["statistics"][0]["games"]["appearances"]
#     minutes = ["statistics"][0]["games"]["minutes"]
#     number = ["statistics"][0]["games"]["number"]
#     position = ["statistics"][0]["games"]["position"]
#     rating = ["statistics"][0]["games"]["rating"]
#     shots = ["statistics"][0]["shots"]["total"]
#     shots_on_target = ["statistics"][0]["shots"]["on"]
#     goals = ["statistics"][0]["goals"]["total"]
#     goals_conceded = ["statistics"][0]["goals"]["conceded"]
#     goals_saved = ["statistics"][0]["goals"]["saves"]
#     assists = ["statistics"][0]["goals"]["assists"]
#     passes = ["statistics"][0]["passes"]["total"]
#     pass_accuracy = ["statistics"][0]["passes"]["accuracy"]
#     tackles = ["statistics"][0]["tackles"]["total"]
#     blocks = ["statistics"][0]["tackles"]["blocks"]
#     interceptions = ["statistics"][0]["tackles"]["interceptions"]
#     duels = ["statistics"][0]["duels"]["total"]
#     duels_won = ["statistics"][0]["duels"]["won"]
#     dribbles_attempted = ["statistics"][0]["dribbles"]["attempts"]
#     dribbles_successful = ["statistics"][0]["dribbles"]["success"]
#     fouls_drawn = ["statistics"][0]["fouls"]["drawn"]
#     fouls_committed = ["statistics"][0]["fouls"]["committed"]
#     yellow_cards = ["statistics"][0]["cards"]["yellow"]
#     red_cards = ["statistics"][0]["cards"]["red"]
#     penalties_won = ["statistics"][0]["penalty"]["won"]
#     penalties_committed = ["statistics"][0]["penalty"]["committed"]
#     penalties_scored = ["statistics"][0]["penalty"]["scored"]
#     penalties_missed = ["statistics"][0]["penalty"]["missed"]
#     penalties_saved = ["statistics"][0]["penalty"]["saved"]

#     player = Player.new(name: name)