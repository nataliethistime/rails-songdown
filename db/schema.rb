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

ActiveRecord::Schema.define(version: 20160904113241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "setlist_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "song_id"
    t.string   "artist"
    t.string   "key"
    t.string   "title"
    t.integer  "setlist_id"
    t.integer  "position"
    t.index ["setlist_id"], name: "index_setlist_items_on_setlist_id", using: :btree
  end

  create_table "setlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.date     "date"
    t.text     "notes"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_setlists_on_user_id", using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.string   "artist"
    t.string   "title"
    t.text     "content"
    t.string   "key"
    t.string   "youtube_url"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "views",                default: 0
    t.string   "full_name"
    t.string   "full_name_searchable"
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
