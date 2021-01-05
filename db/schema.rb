# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_05_145100) do

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.integer "league_id"
    t.integer "season"
    t.string "country"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "nationality"
    t.integer "height"
    t.integer "weight"
    t.integer "team_id"
    t.string "club"
    t.integer "appearances"
    t.integer "minutes"
    t.string "position"
    t.float "rating"
    t.integer "shots"
    t.integer "shots_on_target"
    t.integer "goals"
    t.integer "assists"
    t.integer "tackles"
    t.integer "blocks"
    t.integer "interceptions"
    t.integer "duels"
    t.integer "duels_won"
    t.integer "dribbles_attempted"
    t.integer "dribbles_successful"
    t.integer "fouls_drawn"
    t.integer "fouls_committed"
    t.integer "yellow_cards"
    t.integer "red_cards"
    t.integer "penalties_won"
    t.integer "penalties_committed"
    t.integer "penalties_scored"
    t.integer "penalties_missed"
    t.integer "penalties_saved"
    t.integer "number"
    t.integer "goals_conceded"
    t.integer "goals_saved"
    t.integer "passes"
    t.float "pass_accuracy"
    t.integer "season"
  end

end
