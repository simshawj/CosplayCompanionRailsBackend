class DropUsersTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :users
  end

  def down
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
      t.string   "unconfirmed_email"
    end
    
    add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
    add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree
  end
end
