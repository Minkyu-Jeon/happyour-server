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

ActiveRecord::Schema.define(version: 20170528142819) do

  create_table "franchise_image", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "franchise_id"
    t.string  "url"
    t.index ["franchise_id"], name: "index_franchise_image_on_franchise_id", using: :btree
  end

  create_table "franchises", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",                     null: false
    t.string   "address",     limit: 1000, null: false
    t.string   "description", limit: 1000
    t.string   "code",        limit: 10
    t.string   "open_time",   limit: 8
    t.string   "close_time",  limit: 8
    t.string   "gps"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["code"], name: "index_franchises_on_code", using: :btree
  end

  create_table "invitations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id",         null: false
    t.string   "email"
    t.integer  "invited_user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["invited_user_id"], name: "index_invitations_on_invited_user_id", using: :btree
    t.index ["user_id"], name: "index_invitations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                  default: 0,  null: false
    t.string   "nickname"
    t.string   "recommendation_code"
    t.integer  "social_type",            limit: 1
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["email", "social_type"], name: "index_users_on_email_and_social_type", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["recommendation_code"], name: "index_users_on_recommendation_code", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "franchise_image", "franchises"
  add_foreign_key "invitations", "users"
end
