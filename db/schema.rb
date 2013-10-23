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

ActiveRecord::Schema.define(version: 20131023092357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catalogs_contract_types", force: true do |t|
    t.string   "name"
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_contract_types", ["contract_id"], name: "index_catalogs_contract_types_on_contract_id", using: :btree

  create_table "catalogs_contracts", force: true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.boolean  "def"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_contracts", ["customer_id"], name: "index_catalogs_contracts_on_customer_id", using: :btree

  create_table "catalogs_customers", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_departments", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_departments", ["organization_id"], name: "index_catalogs_departments_on_organization_id", using: :btree

  create_table "catalogs_organizations", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_products", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_talons", force: true do |t|
    t.integer  "amount_id"
    t.integer  "state_id"
    t.integer  "product_id"
    t.string   "barcode"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_talons", ["amount_id"], name: "index_catalogs_talons_on_amount_id", using: :btree
  add_index "catalogs_talons", ["customer_id"], name: "index_catalogs_talons_on_customer_id", using: :btree
  add_index "catalogs_talons", ["product_id"], name: "index_catalogs_talons_on_product_id", using: :btree
  add_index "catalogs_talons", ["state_id"], name: "index_catalogs_talons_on_state_id", using: :btree

  create_table "catalogs_talons_amounts", force: true do |t|
    t.integer  "value"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_talons_states", force: true do |t|
    t.string   "name"
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

  create_table "documents_actions_talons_issues", force: true do |t|
    t.integer  "talons_issue_id"
    t.integer  "talon_id"
    t.decimal  "price"
    t.datetime "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_actions_talons_issues", ["talon_id"], name: "index_documents_actions_talons_issues_on_talon_id", using: :btree
  add_index "documents_actions_talons_issues", ["talons_issue_id"], name: "index_documents_actions_talons_issues_on_talons_issue_id", using: :btree

  create_table "documents_talons_issues", force: true do |t|
    t.integer  "department_id"
    t.integer  "contract_id"
    t.integer  "user_id"
    t.boolean  "held"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents_talons_issues", ["contract_id"], name: "index_documents_talons_issues_on_contract_id", using: :btree
  add_index "documents_talons_issues", ["department_id"], name: "index_documents_talons_issues_on_department_id", using: :btree
  add_index "documents_talons_issues", ["user_id"], name: "index_documents_talons_issues_on_user_id", using: :btree

end
