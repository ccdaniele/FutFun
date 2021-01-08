require_relative '../config/environment'


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

def call_club_stats(club, league, season)
    x  = call(URI("https://v3.football.api-sports.io/teams/statistics?league=#{league}&team=#{club}&season=#{season}"))
end

def call_custom_league(league, season)
    call(URI("https://v3.football.api-sports.io/teams?league=#{league}&season=#{season}"))
end

def call_team(league, club, season)   #could populate both teams and players with data across a league
    call(URI("https://v3.football.api-sports.io/players?season=#{season}&league=#{league}&team=#{club}"))
end

def call_team_players(league, season, team)
    call(URI("https://v3.football.api-sports.io/players?season=#{season}&league=#{league}&team=#{team}"))
end

def call_player(id, season)
    call(URI("https://v3.football.api-sports.io/players?id=#{id}&season=#{season}"))
end

  #           <--------database methods------->


league_array = [39, 140, 78, 61, 135, 253]
seasons = [2017, 2018, 2019]

def league_selection(league)
    if league == "Premier League"
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
    end
    l
end

  #           <--------create methods-------> 

def destroy_all
    Club.destroy_all
    Player.destroy_all
    League.destroy_all
end

def create_all(league_array, season)   #all methods work
    create_leagues_ids
    create_leagues_clubs(league_array, season)
    create_players_across_leagues(league_array, season)
    create_club_stats_across_leagues(league_array, season)
end

def create_leagues_ids(league_array)   #good     #populates with leagues, their ids and basic data
    url = URI("https://v3.football.api-sports.io/leagues?type=league")
    x = call(url)
    x["response"].each do |league|
        league_id = league["league"]["id"]
        name = league["league"]["name"]
        country = league["country"]["name"]
        stats_since = league["seasons"][0]["year"]
        if league_array.include?(league_id)
            League.find_or_create_by(league_id: league_id, name: name, country: country)
        end
    end
end

def create_league_clubs(league, season) #good 1/7
    x = call_custom_league(league, season)
    x["response"].map do |team|
        club_id = team["team"]["id"]
        new_club = Club.find_or_create_by(club_id: club_id)
        new_club.name = team["team"]["name"]
        new_club.country = team["team"]["country"]
        new_club.founded = team["team"]["founded"]
        new_club.stadium = team["venue"]["name"]
        new_club.city = team["venue"]["city"]
        new_club.save
    end
end

def create_leagues_clubs(league_array, season)   #in create_all
    league_array.each do |league|
    create_league_clubs(league, season)
    end
end

def create_club_stats_across_league(league, season)   #basic method for club stats
    x = call_custom_league(league, season)
    x["response"].map do |team|
        club = team["team"]["id"]
        y = call_club_stats(club, league, season)
        club_id = club
        new_club = Club.find_or_create_by(club_id: club_id)
        new_club.name = y["response"]["team"]["name"]
        new_club.form = y["response"]["form"]
        new_club.played = y["response"]["fixtures"]["played"]["total"]
        new_club.wins = y["response"]["fixtures"]["wins"]["total"]
        new_club.draws = y["response"]["fixtures"]["draws"]["total"]
        new_club.losses = y["response"]["fixtures"]["loses"]["total"]
        new_club.goals_for = y["response"]["goals"]["for"]["total"]["total"]
        new_club.goals_against = y["response"]["goals"]["against"]["total"]["total"]
        new_club.clean_sheets = y["response"]["clean_sheet"]["total"]
        new_club.failed_to_score = y["response"]["failed_to_score"]["total"]
        new_club.league_id = league
        new_club.save
    end
end

def create_club_stats_across_leagues(league_array, season)   #in create_all
    league_array.each do |league|
    create_club_stats_across_league(league, season)
    end
end

def create_players_from_clubs_in_league(league, season)   #basic method for players for teams in a league
    x = call_custom_league(league, season)
    x["response"].map do |team|
        club_id = team["team"]["id"]
        y = call_team_players(league, season, club_id)
        y["response"].each do |player|
            player_id = player["player"]["id"]
            create_player(player_id, season)
        end
    end
end

def create_players_across_leagues(league_array, season)      #in create_all
    league_array.each do |league|
        create_players_from_clubs_in_league(league, season) 
    end
end

def create_player(player_id, season) #basic method retrieves a specific player's data
    
    player_stats = call_player(player_id, season)
    player_id = player_stats["parameters"]["id"]
    season = player_stats["parameters"]["season"]
    new_player = Player.find_or_create_by(player_id: player_id)
    new_player.name = player_stats["response"][0]["player"]["name"]
    new_player.club_id = player_stats["response"][0]["statistics"][0]["team"]["id"]
    new_player.age = player_stats["response"][0]["player"]["age"]
    new_player.height = player_stats["response"][0]["player"]["height"]
    new_player.weight = player_stats["response"][0]["player"]["weight"]
    new_player.appearances =  player_stats["response"][0]["statistics"][0]["games"]["appearences"]
    new_player.minutes =  player_stats["response"][0]["statistics"][0]["games"]["minutes"]
    new_player.position =  player_stats["response"][0]["statistics"][0]["games"]["position"]
    new_player.rating =  player_stats["response"][0]["statistics"][0]["games"]["rating"]
    new_player.shots =  player_stats["response"][0]["statistics"][0]["shots"]["total"]
    new_player.shots_on_target =  player_stats["response"][0]["statistics"][0]["shots"]["on"]
    new_player.goals =  player_stats["response"][0]["statistics"][0]["goals"]["total"]
    new_player.goals_conceded =  player_stats["response"][0]["statistics"][0]["goals"]["conceded"]
    new_player.goals_saved =  player_stats["response"][0]["statistics"][0]["goals"]["saves"]
    new_player.assists =  player_stats["response"][0]["statistics"][0]["goals"]["assists"]
    new_player.passes =  player_stats["response"][0]["statistics"][0]["passes"]["total"]
    new_player.pass_accuracy =  player_stats["response"][0]["statistics"][0]["passes"]["accuracy"]
    new_player.tackles =  player_stats["response"][0]["statistics"][0]["tackles"]["total"]
    new_player.blocks =  player_stats["response"][0]["statistics"][0]["tackles"]["blocks"]
    new_player.interceptions =  player_stats["response"][0]["statistics"][0]["tackles"]["interceptions"]
    new_player.duels =  player_stats["response"][0]["statistics"][0]["duels"]["total"]
    new_player.duels_won =  player_stats["response"][0]["statistics"][0]["duels"]["won"]
    new_player.dribbles_attempted =  player_stats["response"][0]["statistics"][0]["dribbles"]["attempts"]
    new_player.dribbles_successful =  player_stats["response"][0]["statistics"][0]["dribbles"]["success"]
    new_player.fouls_drawn =  player_stats["response"][0]["statistics"][0]["fouls"]["drawn"]
    new_player.fouls_committed =  player_stats["response"][0]["statistics"][0]["fouls"]["committed"]
    new_player.yellow_cards =  player_stats["response"][0]["statistics"][0]["cards"]["yellow"]
    new_player.red_cards =  player_stats["response"][0]["statistics"][0]["cards"]["red"]
    new_player.penalties_won =  player_stats["response"][0]["statistics"][0]["penalty"]["won"]
    new_player.penalties_committed =  player_stats["response"][0]["statistics"][0]["penalty"]["committed"]
    new_player.penalties_scored =  player_stats["response"][0]["statistics"][0]["penalty"]["scored"]
    new_player.penalties_missed =  player_stats["response"][0]["statistics"][0]["penalty"]["missed"]
    new_player.penalties_saved =  player_stats["response"][0]["statistics"][0]["penalty"]["saved"]
    new_player.save
    end

    