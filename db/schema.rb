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

ActiveRecord::Schema.define(version: 20160918031840) do

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
    t.integer  "user_id"
    t.index ["convention_id"], name: "index_convention_years_on_convention_id", using: :btree
    t.index ["user_id"], name: "index_convention_years_on_user_id", using: :btree
  end

  create_table "conventions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "logo"
    t.integer  "user_id"
    t.index ["name"], name: "index_conventions_on_name", unique: true, using: :btree
    t.index ["user_id"], name: "index_conventions_on_user_id", using: :btree
  end

  create_table "photo_shoots", force: :cascade do |t|
    t.string   "series"
    t.datetime "start"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "convention_year_id"
    t.integer  "user_id"
    t.index ["convention_year_id"], name: "index_photo_shoots_on_convention_year_id", using: :btree
    t.index ["series", "start", "convention_year_id"], name: "index_photo_shoots_on_series_and_start_and_convention_year_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_photo_shoots_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "convention_years", "conventions"
  add_foreign_key "photo_shoots", "convention_years"
end
