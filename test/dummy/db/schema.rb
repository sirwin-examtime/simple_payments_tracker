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

ActiveRecord::Schema.define(:version => 20121115122858) do

  create_table "payer_payments", :force => true do |t|
    t.integer "payment_item_id", :null => false
    t.integer "payer_id"
    t.string  "payer_type"
  end

  create_table "payment_installments", :force => true do |t|
    t.integer  "payer_payment_id",                                                :null => false
    t.decimal  "amount",           :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.integer  "quantity",                                       :default => 1,   :null => false
    t.string   "type"
    t.string   "comments"
    t.datetime "received_at"
    t.integer  "receiver_id"
    t.string   "receiver_type"
  end

  add_index "payment_installments", ["payer_payment_id"], :name => "index_payment_installments_on_payer_payment_id"
  add_index "payment_installments", ["receiver_id"], :name => "index_payment_installments_on_receiver_id"
  add_index "payment_installments", ["receiver_type"], :name => "index_payment_installments_on_receiver_type"
  add_index "payment_installments", ["type"], :name => "index_payment_installments_on_type"

  create_table "payment_items", :force => true do |t|
    t.string   "title",                                                          :null => false
    t.string   "description"
    t.datetime "due_at"
    t.datetime "expires_at"
    t.boolean  "closed",                                      :default => false, :null => false
    t.string   "type"
    t.decimal  "amount",        :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.integer  "quantity",                                    :default => 1,     :null => false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "grouping_id"
    t.string   "grouping_type"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "payment_items", ["grouping_id"], :name => "index_payment_items_on_grouping_id"
  add_index "payment_items", ["grouping_type"], :name => "index_payment_items_on_grouping_type"
  add_index "payment_items", ["owner_id"], :name => "index_payment_items_on_owner_id"
  add_index "payment_items", ["owner_type"], :name => "index_payment_items_on_owner_type"
  add_index "payment_items", ["type"], :name => "index_payment_items_on_type"

end
