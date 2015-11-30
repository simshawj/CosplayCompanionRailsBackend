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

ActiveRecord::Schema.define(version: 20151130181839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "convention_years", force: :cascade do |t|
    t.date     "start"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "convention_id"
    t.date     "finish"
    t.string   "display"
    t.string   "location"
  end

  add_index "convention_years", ["convention_id"], name: "index_convention_years_on_convention_id", using: :btree

  create_table "conventions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "logo"
  end

  add_index "conventions", ["name"], name: "index_conventions_on_name", unique: true, using: :btree

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
  add_index "photo_shoots", ["series", "start", "convention_year_id"], name: "index_photo_shoots_on_series_and_start_and_convention_year_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "convention_years", "conventions"
  add_foreign_key "photo_shoots", "convention_years"
end
