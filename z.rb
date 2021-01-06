require 'pry'


def player_season
# find_or_create_by(player_id: "#{player_id}", season: "#{season}")

x =     call_player(642).each do |data|     #aguero
        player_id = data["parameters"]["id"]
        season = data["parameters"]["season"]
        age = data["response"][0]["player"]["age"]
        height = data["response"][0]["player"]["height"]
        weight = data["response"][0]["player"]["weight"]
        club = data["response"][0]["statistics"][0]["team"]["name"]
        appearances =  data["response"][0]["statistics"][0]["games"]["appearences"]
        minutes =  data["response"][0]["statistics"][0]["games"]["minutes"]
        #number =  data["response"][0]["statistics"][0]["games"]["number"]
        position =  data["response"][0]["statistics"][0]["games"]["position"]
        rating =  data["response"][0]["statistics"][0]["games"]["rating"]
        shots =  data["response"][0]["statistics"][0]["shots"]["total"]
        shots_on_target =  data["response"][0]["statistics"][0]["shots"]["on"]
        goals =  data["response"][0]["statistics"][0]["goals"]["total"]
        goals_conceded =  data["response"][0]["statistics"][0]["goals"]["conceded"]
        goals_saved =  data["response"][0]["statistics"][0]["goals"]["saves"]
        assists =  data["response"][0]["statistics"][0]["goals"]["assists"]
        passes =  data["response"][0]["statistics"][0]["passes"]["total"]
        pass_accuracy =  data["response"][0]["statistics"][0]["passes"]["accuracy"]
        tackles =  data["response"][0]["statistics"][0]["tackles"]["total"]
        blocks =  data["response"][0]["statistics"][0]["tackles"]["blocks"]
        interceptions =  data["response"][0]["statistics"][0]["tackles"]["interceptions"]
        duels =  data["response"][0]["statistics"][0]["duels"]["total"]
        duels_won =  data["response"][0]["statistics"][0]["duels"]["won"]
        dribbles_attempted =  data["response"][0]["statistics"][0]["dribbles"]["attempts"]
        dribbles_successful =  data["response"][0]["statistics"][0]["dribbles"]["success"]
        fouls_drawn =  data["response"][0]["statistics"][0]["fouls"]["drawn"]
        fouls_committed =  data["response"][0]["statistics"][0]["fouls"]["committed"]
        yellow_cards =  data["response"][0]["statistics"][0]["cards"]["yellow"]
        red_cards =  data["response"][0]["statistics"][0]["cards"]["red"]
        penalties_won =  data["response"][0]["statistics"][0]["penalty"]["won"]
        penalties_committed =  data["response"][0]["statistics"][0]["penalty"]["committed"]
        penalties_scored =  data["response"][0]["statistics"][0]["penalty"]["scored"]
        penalties_missed =  data["response"][0]["statistics"][0]["penalty"]["missed"]
        penalties_saved =  data["response"][0]["statistics"][0]["penalty"]["saved"]
    end
end
binding.pry

def create_player
        
        player = Player.create({name: name, nationality: nationality})
    
        x["response"][0]["statistics"][0]

    end
    