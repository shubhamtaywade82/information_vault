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

ActiveRecord::Schema.define(version: 20210118151054) do

  create_table "credential_attrs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credential_attrs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",           null: false
    t.string   "email",              null: false
    t.string   "password_digest",    null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "vault_item_accesses", force: :cascade do |t|
    t.integer  "vault_item_id"
    t.integer  "granted_by_id"
    t.integer  "accessor_id"
    t.datetime "expire_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["accessor_id"], name: "index_vault_item_accesses_on_accessor_id"
    t.index ["granted_by_id"], name: "index_vault_item_accesses_on_granted_by_id"
    t.index ["vault_item_id"], name: "index_vault_item_accesses_on_vault_item_id"
  end

  create_table "vault_item_credentials", force: :cascade do |t|
    t.integer  "vault_item_id"
    t.integer  "credential_attr_id"
    t.string   "value",              null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["credential_attr_id"], name: "index_vault_item_credentials_on_credential_attr_id"
    t.index ["vault_item_id"], name: "index_vault_item_credentials_on_vault_item_id"
  end

  create_table "vault_items", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "user_id"
    t.integer  "item_type",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vault_items_on_user_id"
  end

end
