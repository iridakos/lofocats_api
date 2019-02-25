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

ActiveRecord::Schema.define(version: 20150920192224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_tokens", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentication_tokens", ["expires_at"], name: "index_authentication_tokens_on_expires_at", using: :btree
  add_index "authentication_tokens", ["token"], name: "index_authentication_tokens_on_token", unique: true, using: :btree
  add_index "authentication_tokens", ["user_id"], name: "index_authentication_tokens_on_user_id", using: :btree

  create_table "cat_entries", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.string   "breed",         null: false
    t.string   "color",         null: false
    t.string   "longitude",     null: false
    t.string   "latitude",      null: false
    t.string   "contact_phone", null: false
    t.string   "contact_email", null: false
    t.date     "event_date",    null: false
    t.string   "entry_type",    null: false
    t.boolean  "resolved"
    t.string   "chip"
    t.text     "photo_url",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "cat_entries", ["chip"], name: "index_cat_entries_on_chip", using: :btree
  add_index "cat_entries", ["entry_type"], name: "index_cat_entries_on_entry_type", using: :btree
  add_index "cat_entries", ["event_date"], name: "index_cat_entries_on_event_date", using: :btree
  add_index "cat_entries", ["resolved"], name: "index_cat_entries_on_resolved", using: :btree
  add_index "cat_entries", ["user_id"], name: "index_cat_entries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           default: "", null: false
    t.string   "password_digest", default: "", null: false
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
