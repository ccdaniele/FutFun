class League < ActiveRecord::Base

    has_many :seasons
    has_many :clubs
    has_many :players, through: :clubs

    self.primary_key = "league_id"
end