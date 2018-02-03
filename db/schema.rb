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

ActiveRecord::Schema.define(version: 20180203060553) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email",                       null: false
    t.string "password_digest",             null: false
    t.string "name",            limit: 100, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
  end

  create_table "happyhours", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "store_id",                              null: false
    t.integer  "day_of_week", limit: 1,                 null: false
    t.string   "start_time",  limit: 8
    t.string   "end_time",    limit: 8
    t.boolean  "is_holiday",            default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["day_of_week"], name: "index_happyhours_on_day_of_week", using: :btree
    t.index ["store_id"], name: "index_happyhours_on_store_id", using: :btree
  end

  create_table "hash_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "store_id",   null: false
    t.string   "tag_name",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_hash_tags_on_store_id", using: :btree
    t.index ["tag_name"], name: "index_hash_tags_on_tag_name", using: :btree
  end

  create_table "menu_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "menu_id", null: false
    t.string  "url"
    t.index ["menu_id"], name: "index_menu_images_on_menu_id", using: :btree
  end

  create_table "menus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "store_id",         null: false
    t.string   "name",             null: false
    t.integer  "price"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "discounted_price"
    t.index ["store_id"], name: "index_menus_on_store_id", using: :btree
  end

  create_table "review_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "review_id", null: false
    t.string  "url",       null: false
    t.index ["review_id"], name: "index_review_images_on_review_id", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "evaluation", limit: 1
    t.text     "eval_text",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "menu_id"
    t.integer  "user_id"
    t.index ["menu_id"], name: "index_reviews_on_menu_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "store_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "store_id"
    t.string  "url"
    t.index ["store_id"], name: "index_store_images_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                       null: false
    t.string   "address",       limit: 1000, null: false
    t.string   "description",   limit: 1000
    t.string   "open_time",     limit: 8
    t.string   "close_time",    limit: 8
    t.string   "gps"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "promotion_tag"
  end

  create_table "user_devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",      null: false
    t.string   "os_type"
    t.string   "device_id"
    t.string   "push_token"
    t.string   "access_token", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["access_token"], name: "index_user_devices_on_access_token", using: :btree
    t.index ["user_id"], name: "index_user_devices_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "nickname"
    t.integer  "social_type",     limit: 1
    t.string   "password_digest",            null: false
    t.string   "phone_number",    limit: 15
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "loginid",                    null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["loginid"], name: "index_users_on_loginid", unique: true, using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", using: :btree
    t.index ["phone_number"], name: "index_users_on_phone_number", using: :btree
  end

  add_foreign_key "happyhours", "stores"
  add_foreign_key "hash_tags", "stores"
  add_foreign_key "menu_images", "menus"
  add_foreign_key "menus", "stores"
  add_foreign_key "review_images", "reviews"
  add_foreign_key "reviews", "menus"
  add_foreign_key "reviews", "users"
  add_foreign_key "store_images", "stores"
  add_foreign_key "user_devices", "users"
end
