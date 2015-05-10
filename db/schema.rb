# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150509021758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "convention_years", force: :cascade do |t|
    t.integer  "year"
    t.date     "start"
    t.integer  "days"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "convention_id"
  end

  add_index "convention_years", ["convention_id"], name: "index_convention_years_on_convention_id", using: :btree

  create_table "conventions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "photo_shoots", force: :cascade do |t|
    t.string   "series"
    t.datetime "start"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "convention_year_id"
  end

  add_index "photo_shoots", ["convention_year_id"], name: "index_photo_shoots_on_convention_year_id", using: :btree

  add_foreign_key "convention_years", "conventions"
  add_foreign_key "photo_shoots", "convention_years"
end
