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

ActiveRecord::Schema.define(version: 20130617195146) do

  create_table "blogpostings", force: true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "blogpostings", ["id"], name: "index_blogpostings_on_id"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "blogposting_id"
    t.string   "content",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fileposting_id"
  end

  add_index "comments", ["user_id", "blogposting_id"], name: "index_comments_on_user_id_and_blogposting_id"

  create_table "filepostings", force: true do |t|
    t.integer  "user_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "filetype"
  end

  create_table "friendships", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.boolean "approved"
  end

  create_table "personalpostings", force: true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "avatar"
    t.string   "email"
    t.boolean  "public_profile"
  end

  create_table "videopostings", force: true do |t|
    t.string   "title"
    t.string   "videofile"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
