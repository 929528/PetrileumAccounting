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

ActiveRecord::Schema.define(version: 20131201131128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catalogs_contract_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "freebie"
  end

  create_table "catalogs_contracts", force: true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.boolean  "def"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contract_type_id"
    t.boolean  "freebie"
    t.integer  "validity"
  end

  add_index "catalogs_contracts", ["contract_type_id"], name: "index_catalogs_contracts_on_contract_type_id", using: :btree
  add_index "catalogs_contracts", ["customer_id"], name: "index_catalogs_contracts_on_customer_id", using: :btree

  create_table "catalogs_customers", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activated",  default: false
    t.string   "email"
  end

  create_table "catalogs_departments", force: true do |t|
    t.string   "name"
    t.string   "fullname"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs_departments", ["organization_id"], name: "index_catalogs_departments_on_organization_id", using: :btree

  create_table "catalogs_employees", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.string   "lastname"
  end

  add_index "catalogs_employees", ["department_id"], name: "index_catalogs_employees_on_department_id", using: :btree

  create_table "catalogs_employees_rights", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "catalogs_profiles", force: true do |t|
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
  end

  add_index "catalogs_profiles", ["user_id", "user_type"], name: "index_catalogs_profiles_on_user_id_and_user_type", using: :btree

  create_table "catalogs_promotions", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.text     "descr"
    t.string   "href"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "usage"
  end

  create_table "catalogs_talons", force: true do |t|
    t.integer  "amount_id"
    t.integer  "state_id"
    t.integer  "product_id"
    t.string   "barcode"
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires"
  end

  add_index "catalogs_talons", ["amount_id"], name: "index_catalogs_talons_on_amount_id", using: :btree
  add_index "catalogs_talons", ["contract_id"], name: "index_catalogs_talons_on_contract_id", using: :btree
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

  create_table "discounts", force: true do |t|
    t.integer  "product_id"
    t.integer  "customer_id"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discounts", ["customer_id"], name: "index_discounts_on_customer_id", using: :btree
  add_index "discounts", ["product_id"], name: "index_discounts_on_product_id", using: :btree

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

  create_table "documents_actions_talons_repaids", force: true do |t|
    t.integer  "talons_repaid_id"
    t.integer  "talon_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contract_id"
  end

  add_index "documents_actions_talons_repaids", ["contract_id"], name: "index_documents_actions_talons_repaids_on_contract_id", using: :btree
  add_index "documents_actions_talons_repaids", ["talon_id"], name: "index_documents_actions_talons_repaids_on_talon_id", using: :btree
  add_index "documents_actions_talons_repaids", ["talons_repaid_id"], name: "index_documents_actions_talons_repaids_on_talons_repaid_id", using: :btree

  create_table "documents_talons_issues", force: true do |t|
    t.integer  "department_id"
    t.integer  "contract_id"
    t.integer  "user_id"
    t.boolean  "held",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "sum"
  end

  add_index "documents_talons_issues", ["contract_id"], name: "index_documents_talons_issues_on_contract_id", using: :btree
  add_index "documents_talons_issues", ["department_id"], name: "index_documents_talons_issues_on_department_id", using: :btree
  add_index "documents_talons_issues", ["user_id"], name: "index_documents_talons_issues_on_user_id", using: :btree

  create_table "documents_talons_repaids", force: true do |t|
    t.integer  "department_id"
    t.integer  "user_id"
    t.boolean  "held",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "sum"
  end

  add_index "documents_talons_repaids", ["department_id"], name: "index_documents_talons_repaids_on_department_id", using: :btree
  add_index "documents_talons_repaids", ["user_id"], name: "index_documents_talons_repaids_on_user_id", using: :btree

  create_table "price_records", force: true do |t|
    t.integer  "price_id"
    t.integer  "user_id"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_records", ["price_id"], name: "index_price_records_on_price_id", using: :btree
  add_index "price_records", ["user_id"], name: "index_price_records_on_user_id", using: :btree

  create_table "prices", force: true do |t|
    t.integer  "product_id"
    t.integer  "department_id"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["department_id"], name: "index_prices_on_department_id", using: :btree
  add_index "prices", ["product_id"], name: "index_prices_on_product_id", using: :btree

end
