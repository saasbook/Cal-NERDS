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

ActiveRecord::Schema.define(version: 20191119222412) do

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "user_id"
    t.datetime "start_date"
    t.string   "mon_times"
    t.string   "tue_times"
    t.string   "wed_times"
    t.string   "thu_times"
    t.string   "fri_times"
    t.string   "mon_var_times"
    t.string   "tue_var_times"
    t.string   "wed_var_times"
    t.string   "thu_var_times"
    t.string   "fri_var_times"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "google_token"
    t.string   "google_refresh_token"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.string   "email"
    t.string   "name"
    t.boolean  "admin"
    t.boolean  "auth"
  end

end
