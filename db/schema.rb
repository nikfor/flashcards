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

ActiveRecord::Schema.define(version: 20160630230543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "cards", force: :cascade do |t|
    t.string   "original_text",                        null: false
    t.string   "translated_text",                      null: false
    t.datetime "review_date"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "pack_id",                              null: false
    t.integer  "count_success_attempts",   default: 0
    t.integer  "count_unsuccess_attempts", default: 0
  end

  create_table "packs", force: :cascade do |t|
    t.string   "name",                       null: false
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "current",    default: false
  end

  add_index "packs", ["user_id"], name: "index_packs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "crypted_password"
    t.string   "salt"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
