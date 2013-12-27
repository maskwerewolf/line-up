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

ActiveRecord::Schema.define(:version => 20131219123830) do

  create_table "user_queues", :force => true do |t|
    t.string   "account_name"
    t.integer  "in_queue_num",             :default => 0
    t.integer  "out_queue_num",            :default => 0
    t.integer  "idle_queue_num",           :default => 0
    t.integer  "queue_type"
    t.integer  "acquisition_amount_count", :default => 0
    t.integer  "last_acquisition_amount",  :default => 0
    t.datetime "last_acquisition_time"
    t.integer  "acquisition_amount_total", :default => 0
    t.boolean  "is_acquisition_amount",    :default => false
    t.boolean  "is_in_queue",              :default => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

end
