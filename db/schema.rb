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

ActiveRecord::Schema.define(:version => 20111011093502) do

  create_table "hack_tag_follows", :force => true do |t|
    t.integer  "hack_tag_id"
    t.integer  "greater_hack_tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hack_tags", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
    t.boolean  "category_flag"
    t.boolean  "picture_flag"
    t.integer  "created_by"
    t.integer  "singled_by"
    t.boolean  "root_flag"
  end

  create_table "hacks_scopes", :force => true do |t|
    t.integer  "hack_tag_id"
    t.integer  "scope_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties_hacktags", :force => true do |t|
    t.integer "party_id"
    t.integer "hack_tag_id"
  end

  create_table "parties_scopes", :force => true do |t|
    t.integer  "party_id"
    t.integer  "scope_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "progres", :force => true do |t|
    t.boolean  "success"
    t.integer  "hack_tag_id"
    t.integer  "user_id"
    t.datetime "done_when"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope_id"
    t.integer  "cheered_by"
    t.time     "start_time"
    t.boolean  "graduated"
    t.boolean  "dropout"
    t.integer  "party_id"
    t.string   "comment"
    t.boolean  "instruction_flag"
  end

  add_index "progres", ["hack_tag_id"], :name => "index_progres_on_hack_tag_id"

  create_table "scopes", :force => true do |t|
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uid"
    t.string   "screen_name"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "image_url"
    t.datetime "wakeup_time"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_hacktags", :force => true do |t|
    t.integer  "user_id"
    t.integer  "hack_tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_scopes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "scope_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
