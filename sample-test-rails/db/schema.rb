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

ActiveRecord::Schema.define(version: 20150516204645) do

  create_table "attends", id: false, force: :cascade do |t|
    t.integer  "user_id",     limit: 4, null: false
    t.integer  "event_id",    limit: 4, null: false
    t.datetime "reserved_at",           null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "name",       limit: 100, null: false
    t.datetime "start_date",             null: false
  end

  add_index "events", ["id"], name: "id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "name",     limit: 100, null: false
    t.string  "password", limit: 100, null: false
    t.string  "email",    limit: 100, null: false
    t.integer "group_id", limit: 4,   null: false
    t.string  "token",    limit: 255
  end

  add_index "users", ["id"], name: "id", unique: true, using: :btree

end
