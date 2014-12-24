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

ActiveRecord::Schema.define(:version => 20141224164733) do

  create_table "hashtags", :force => true do |t|
    t.string   "text"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "taggings_count"
  end

  create_table "musings", :force => true do |t|
    t.string   "muse_id"
    t.string   "title"
    t.string   "apply_link"
    t.string   "company_logo"
    t.datetime "muse_created_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tweet_id"
    t.integer  "hashtag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["hashtag_id"], :name => "index_taggings_on_hashtag_id"
  add_index "taggings", ["tweet_id"], :name => "index_taggings_on_tweet_id"

  create_table "tweets", :force => true do |t|
    t.string   "twitter_id"
    t.string   "text"
    t.string   "tweeter"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.datetime "twitter_created_at"
    t.string   "tweeter_avatar"
    t.boolean  "by_friend",          :default => false
    t.string   "tweeter_id"
  end

end
