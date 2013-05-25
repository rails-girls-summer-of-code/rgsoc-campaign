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

ActiveRecord::Schema.define(:version => 20130524154923) do

  create_table "addresses", :force => true do |t|
    t.integer  "donation_id"
    t.string   "donation_type"
    t.string   "name"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "donations", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_token"
    t.string   "stripe_id"
    t.string   "package"
    t.integer  "amount"
    t.boolean  "subscription", :default => false, :null => false
    t.text     "comment"
    t.text     "message"
    t.string   "vat_id"
    t.boolean  "add_vat"
    t.boolean  "active",       :default => true,  :null => false
    t.datetime "cancelled_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "twitter_uid"
    t.string   "twitter_handle"
    t.integer  "github_uid"
    t.string   "github_handle"
    t.string   "homepage"
    t.string   "description"
    t.boolean  "display",                :default => true
    t.boolean  "company",                :default => true
    t.string   "stripe_plan"
    t.string   "stripe_customer_id"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

end
