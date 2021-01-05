class League < ActiveRecord::Base
    has_many :clubs
    has_many :players, through: :clubs
end