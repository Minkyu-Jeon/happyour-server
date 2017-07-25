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

ActiveRecord::Schema.define(version: 20170725142258) do

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

  create_table "invitations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",         null: false
    t.string   "email"
    t.integer  "invited_user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["invited_user_id"], name: "index_invitations_on_invited_user_id", using: :btree
    t.index ["user_id"], name: "index_invitations_on_user_id", using: :btree
  end

  create_table "menu_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "menu_id", null: false
    t.string  "url"
    t.index ["menu_id"], name: "index_menu_images_on_menu_id", using: :btree
  end

  create_table "menus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "store_id",   null: false
    t.string   "name",       null: false
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_menus_on_store_id", using: :btree
  end

  create_table "order_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_id",                 null: false
    t.integer "evaluation", limit: 1
    t.text    "eval_text",  limit: 65535
    t.string  "url"
    t.index ["order_id"], name: "index_order_histories_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                    null: false
    t.integer  "menu_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_receive", default: false
    t.index ["is_receive"], name: "index_orders_on_is_receive", using: :btree
    t.index ["menu_id"], name: "index_orders_on_menu_id", using: :btree
    t.index ["user_id", "is_receive"], name: "index_orders_on_user_id_and_is_receive", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "store_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "store_id"
    t.string  "url"
    t.index ["store_id"], name: "index_store_images_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                     null: false
    t.string   "address",     limit: 1000, null: false
    t.string   "description", limit: 1000
    t.string   "code",        limit: 10
    t.string   "open_time",   limit: 8
    t.string   "close_time",  limit: 8
    t.string   "gps"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["code"], name: "index_stores_on_code", using: :btree
  end

  create_table "subscription_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",         null: false
    t.integer  "subscription_id", null: false
    t.datetime "expired_at",      null: false
    t.integer  "invitation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["expired_at"], name: "index_subscription_users_on_expired_at", using: :btree
    t.index ["invitation_id"], name: "index_subscription_users_on_invitation_id", using: :btree
    t.index ["subscription_id"], name: "index_subscription_users_on_subscription_id", using: :btree
    t.index ["user_id"], name: "index_subscription_users_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                       null: false
    t.integer  "subscription_type", limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "days",                        null: false
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
    t.string   "email",                          null: false
    t.string   "nickname"
    t.string   "recommendation_code"
    t.integer  "social_type",         limit: 1
    t.string   "password_digest",                null: false
    t.string   "phone_number",        limit: 15
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", using: :btree
    t.index ["phone_number"], name: "index_users_on_phone_number", using: :btree
    t.index ["recommendation_code"], name: "index_users_on_recommendation_code", using: :btree
  end

  add_foreign_key "happyhours", "stores"
  add_foreign_key "invitations", "users"
  add_foreign_key "menu_images", "menus"
  add_foreign_key "menus", "stores"
  add_foreign_key "order_histories", "orders"
  add_foreign_key "orders", "menus"
  add_foreign_key "orders", "users"
  add_foreign_key "store_images", "stores"
  add_foreign_key "subscription_users", "subscriptions"
  add_foreign_key "subscription_users", "users"
  add_foreign_key "user_devices", "users"
end
