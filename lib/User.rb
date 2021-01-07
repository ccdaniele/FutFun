class User < ActiveRecord::Base 
    has_many :clubs
    has_many :players


    def storage_players(player)
        player_profile = Player.find_by_name(player)
        self.favorite_players << player_profile.id
    end

   

end