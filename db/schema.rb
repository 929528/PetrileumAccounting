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

ActiveRecord::Schema.define(version: 20131018124905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catalogs_contract_types", force: true do |t|
    t.string   "name"
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_contract_types", ["contract_id"], name: "index_catalogs_contract_types_on_contract_id", using: :btree

  create_table "catalogs_customer_contracts", force: true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.boolean  "def"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_customer_contracts", ["customer_id"], name: "index_catalogs_customer_contracts_on_customer_id", using: :btree
  add_index "catalogs_customer_contracts", ["type_id"], name: "index_catalogs_customer_contracts_on_type_id", using: :btree

  create_table "catalogs_customers", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_users", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
