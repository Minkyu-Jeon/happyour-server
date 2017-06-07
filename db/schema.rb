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

ActiveRecord::Schema.define(version: 20170607085221) do

  create_table "franchise_image", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "franchise_id"
    t.string  "url"
    t.index ["franchise_id"], name: "index_franchise_image_on_franchise_id", using: :btree
  end

  create_table "franchises", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.integer  "franchise_id", null: false
    t.string   "name",         null: false
    t.integer  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["franchise_id"], name: "index_menus_on_franchise_id", using: :btree
  end

  create_table "order_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_id",                 null: false
    t.integer "evaluation", limit: 1
    t.text    "eval_text",  limit: 65535
    t.string  "url"
    t.index ["order_id"], name: "index_order_histories_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.integer  "menu_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_orders_on_menu_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                          default: "", null: false
    t.string   "nickname"
    t.string   "recommendation_code"
    t.integer  "social_type",         limit: 1
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "user_token"
    t.string   "user_secret"
    t.string   "password_digest",                default: "", null: false
    t.string   "phone_number",        limit: 15
    t.index ["email", "social_type"], name: "index_users_on_email_and_social_type", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["recommendation_code"], name: "index_users_on_recommendation_code", using: :btree
    t.index ["user_secret"], name: "index_users_on_user_secret", using: :btree
    t.index ["user_token"], name: "index_users_on_user_token", using: :btree
  end

  add_foreign_key "franchise_image", "franchises"
  add_foreign_key "invitations", "users"
  add_foreign_key "menu_images", "menus"
  add_foreign_key "menus", "franchises"
  add_foreign_key "order_histories", "orders"
  add_foreign_key "orders", "menus"
  add_foreign_key "orders", "users"
end
