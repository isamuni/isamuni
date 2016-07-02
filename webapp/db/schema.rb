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

ActiveRecord::Schema.define(version: 20160624213850) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "pages", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "kind",        null: false
    t.integer  "owner_id",    null: false
    t.boolean  "active"
    t.string   "links"
    t.string   "description"
    t.string   "contacts"
    t.string   "coordinates"
    t.string   "location"
    t.string   "lookingfor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug",        null: false
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true

  create_table "posts", force: :cascade do |t|
    t.string   "uid"
    t.string   "author_name"
    t.string   "author_uid"
    t.string   "link"
    t.text     "content"
    t.string   "post_type"
    t.string   "tags"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name",             null: false
    t.string   "oauth_token"
    t.string   "occupation"
    t.datetime "oauth_expires_at"
    t.text     "description"
    t.text     "projects"
    t.text     "links"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "slug",             null: false
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

end
