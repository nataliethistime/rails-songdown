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

ActiveRecord::Schema.define(version: 20160819043805) do

  create_table "setlist_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "song_id"
    t.string   "artist"
    t.string   "key"
    t.string   "title"
    t.integer  "setlist_id"
  end

  add_index "setlist_items", ["setlist_id"], name: "index_setlist_items_on_setlist_id"

  create_table "setlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "date"
    t.string   "title"
    t.text     "notes"
    t.integer  "user_id"
  end

  add_index "setlists", ["user_id"], name: "index_setlists_on_user_id"

  create_table "songs", force: :cascade do |t|
    t.string   "artist"
    t.string   "title"
    t.text     "content"
    t.string   "key"
    t.string   "youtube"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "views"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "role",               default: "user"
  end

end