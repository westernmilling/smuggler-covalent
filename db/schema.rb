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

ActiveRecord::Schema.define(version: 20141130024523) do

  create_table "entities", force: true do |t|
    t.string   "cached_full_name",            null: false
    t.string   "display_name",                null: false
    t.string   "name",                        null: false
    t.string   "contact_name"
    t.string   "comments"
    t.string   "reference",                   null: false
    t.string   "street_address",              null: false
    t.string   "city",                        null: false
    t.string   "region",                      null: false
    t.string   "region_code",                 null: false
    t.string   "country",                     null: false
    t.string   "roles",                       null: false
    t.string   "source",                      null: false
    t.string   "uuid",             limit: 36, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entity_translations", force: true do |t|
    t.integer  "entity_id",    null: false
    t.string   "sender_value", null: false
    t.string   "source_field", null: false
    t.string   "source_value", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_translations", force: true do |t|
    t.integer  "product_id",   null: false
    t.string   "sender_value", null: false
    t.string   "source_field", null: false
    t.string   "source_value", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "display_name",            null: false
    t.string   "name",                    null: false
    t.string   "reference",               null: false
    t.string   "source",                  null: false
    t.string   "uuid",         limit: 36, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name",            null: false
    t.string   "uuid",         limit: 36
    t.integer  "is_active"
    t.string   "roles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
