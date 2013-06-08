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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130608165215) do

  create_table "applications", :force => true do |t|
    t.string   "timestamp"
    t.string   "student_name"
    t.string   "student_email"
    t.string   "pair_name"
    t.string   "pair_email"
    t.string   "living_costs"
    t.text     "data"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "hidden",             :default => false
    t.string   "sponsor_pick"
    t.string   "country"
    t.integer  "min_living"
    t.integer  "project_visibility"
    t.string   "project_name"
    t.string   "comment"
  end

  add_index "applications", ["timestamp"], :name => "index_applications_on_timestamp"

  create_table "comments", :force => true do |t|
    t.integer  "application_id"
    t.string   "author_name"
    t.text     "text"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "donations", :force => true do |t|
    t.string   "stripe_card_token"
    t.string   "stripe_customer_id"
    t.string   "package"
    t.integer  "amount"
    t.string   "vat_id"
    t.boolean  "add_vat"
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "twitter_handle"
    t.string   "github_handle"
    t.string   "homepage"
    t.boolean  "display",            :default => true
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.text     "comment"
    t.string   "gravatar_url"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "application_id"
    t.string   "user_name"
    t.text     "data"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
