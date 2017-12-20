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

ActiveRecord::Schema.define(version: 20171220151218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "favorable_id"
    t.string "favorable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favorable_id"], name: "index_favorites_on_favorable_id"
    t.index ["user_id", "favorable_id", "favorable_type"], name: "index_favorites_on_user_id_and_favorable_id_and_favorable_type", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.text "body"
    t.string "quarter"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "parent_id"
    t.bigint "user_id"
    t.date "end_date"
    t.bigint "imported_id"
    t.index ["team_id"], name: "index_goals_on_team_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.integer "goal_id"
    t.integer "linked_goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer "amount"
    t.text "reason"
    t.bigint "user_id"
    t.bigint "goal_id"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "learnings"
    t.integer "confidence"
    t.index ["goal_id"], name: "index_scores_on_goal_id"
    t.index ["status_id"], name: "index_scores_on_status_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.string "hex_color"
    t.integer "ordinal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "require_learnings"
    t.bigint "imported_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.bigint "imported_id"
    t.index ["parent_id"], name: "index_teams_on_parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.boolean "admin"
    t.bigint "imported_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "favorites", "users"
  add_foreign_key "goals", "teams"
  add_foreign_key "goals", "users"
  add_foreign_key "scores", "goals"
  add_foreign_key "scores", "statuses"
  add_foreign_key "scores", "users"
end
