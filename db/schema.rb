# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_13_023234) do

  create_table "cards", force: :cascade do |t|
    t.string "text"
    t.integer "card_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "pin"
    t.integer "game_status", default: 0
    t.integer "round_status", default: 0
    t.integer "current_round", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "played_cards", force: :cascade do |t|
    t.integer "card_id"
    t.integer "game_id"
    t.text "token"
    t.integer "round_number", default: 0
    t.boolean "winner", default: false
    t.index ["card_id"], name: "index_played_cards_on_card_id"
    t.index ["game_id"], name: "index_played_cards_on_game_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.text "player_hand", default: "--- []\n"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "game_id"
    t.index ["game_id"], name: "index_sessions_on_game_id"
    t.index ["token"], name: "index_sessions_on_token", unique: true
  end

end
