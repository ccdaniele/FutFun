class Season < ActiveRecord::Base

    self.primary_key = "season"

    belongs_to :league
    has_many :teams
    has_many :teams, through: :leagues
    has_many :team_datas, through: :teams
    has_many :players
    has_many :players, through: :teams
    has_many :players_stats, through: :players

    
end

