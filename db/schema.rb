# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_18_084601) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sprints", force: :cascade do |t|
    t.string "name", null: false
    t.date "during_from", null: false
    t.date "during_to", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "handicap_worked", default: 0.0, null: false
    t.float "handicap_billable", default: 0.0, null: false
  end

  create_table "unworked_days", force: :cascade do |t|
    t.date "day", null: false
    t.string "reason"
    t.index ["day"], name: "index_unworked_days_on_day", unique: true
  end

end
