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

ActiveRecord::Schema.define(version: 20161105185042) do

  create_table "allowedusers", force: :cascade do |t|
    t.string   "group_uid"
    t.string   "user_uid"
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "uid"
    t.string   "name"
    t.text     "content"
    t.string   "organiser"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "location_name"
    t.string   "location"
    t.string   "coordinates"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",         null: false
    t.integer  "kind",         null: false
    t.integer  "owner_id",     null: false
    t.boolean  "active"
    t.string   "sector"
    t.string   "no_employees"
    t.string   "links"
    t.string   "description"
    t.string   "contacts"
    t.string   "coordinates"
    t.string   "location"
    t.string   "lookingfor"
    t.string   "fbpage"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "slug",         null: false
    t.string   "twitterpage"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string   "uid"
    t.string   "author_name"
    t.string   "author_uid"
    t.string   "link"
    t.string   "picture"
    t.text     "content"
    t.string   "post_type"
    t.string   "tags"
    t.string   "caption"
    t.string   "description"
    t.string   "name"
    t.boolean  "show"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name",                             null: false
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "occupation"
    t.text     "description"
    t.text     "projects"
    t.text     "links"
    t.text     "tags"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "slug",                             null: false
    t.boolean  "banned",           default: false
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

end
