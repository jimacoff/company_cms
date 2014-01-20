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

ActiveRecord::Schema.define(version: 20140120091128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: true do |t|
    t.string   "file",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  add_index "images", ["created_at"], name: "index_images_on_created_at", using: :btree
  add_index "images", ["imageable_id"], name: "index_images_on_imageable_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "email",      null: false
    t.string   "name"
    t.string   "subject"
    t.text     "message",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["email"], name: "index_messages_on_email", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree

  create_table "services", force: true do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.string   "image",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["created_at"], name: "index_services_on_created_at", using: :btree
  add_index "services", ["name"], name: "index_services_on_name", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.integer  "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["title"], name: "index_tasks_on_title", using: :btree

  create_table "team_members", force: true do |t|
    t.string   "title",       null: false
    t.string   "name",        null: false
    t.text     "description", null: false
    t.string   "avatar",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_members", ["created_at"], name: "index_team_members_on_created_at", using: :btree
  add_index "team_members", ["name"], name: "index_team_members_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "works", force: true do |t|
    t.string   "name",         null: false
    t.string   "client_name",  null: false
    t.text     "story",        null: false
    t.string   "techs",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_photo"
    t.string   "link"
    t.string   "client_info"
    t.text     "client_quote"
  end

  add_index "works", ["created_at"], name: "index_works_on_created_at", using: :btree
  add_index "works", ["name"], name: "index_works_on_name", using: :btree

end
