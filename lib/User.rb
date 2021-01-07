class User < ActiveRecord::Base 
    has_many :clubs
    has_many :players

end