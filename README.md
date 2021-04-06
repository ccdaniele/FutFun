# FUT FUN

Fut Fun is a database of soccer information spanning the MLS and prominent leagues in Europe. It is designed to provide easy access to common information such as league standings and top scorers while also pointing to more curious data analysis. We have introduced the program with a scope of one season but aim to expand the data analysis across several seasons.

Installation:
Run bundle install

To Populate Database:
- run ruby ../db/seeding_methods.rb
- call create_all(league_array, season), where season is the year (YYYY) of your choice. The database is populated from API-Football, however, which only contains data back to 2010 for most teams.

Note: If populating with a current season, the information will be updated each time the create_all method is called with the argument of the season. 

FutFun video ----->>>> https://youtu.be/1guxK1IcGYY 
