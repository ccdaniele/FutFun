class Club < ActiveRecord::Base
    has_many :players
    belongs_to :league
    
    self.primary_key = "club_id"

end
