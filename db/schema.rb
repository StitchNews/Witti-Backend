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

ActiveRecord::Schema.define(version: 20150426060307) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "text"
    t.string   "url"
    t.string   "author"
    t.string   "date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "html"
    t.datetime "date_published"
  end

  create_table "collection_highlights", force: :cascade do |t|
    t.integer  "collection_id"
    t.integer  "highlight_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "highlights", force: :cascade do |t|
    t.string   "article_url"
    t.string   "article_title"
    t.string   "text"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "collection_id"
    t.string   "author"
  end

  create_table "images", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.float    "width"
    t.float    "height"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
