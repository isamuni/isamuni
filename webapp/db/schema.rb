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

ActiveRecord::Schema.define(version: 20160618070154) do

  create_table "pages", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.boolean  "active"
    t.string   "links"
    t.string   "description"
    t.string   "contacts"
    t.string   "coordinates"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "author_name"
    t.string   "author_uid"
    t.string   "link"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.text     "description"
    t.text     "projects"
    t.text     "links"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
