# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_27_164337) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "list_items", force: :cascade do |t|
    t.integer "list_id", null: false
    t.string "external_api_identifier", null: false
    t.string "title", null: false
    t.integer "rank", null: false
    t.string "user_comment"
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_items_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title", limit: 128, null: false
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_lists_on_category_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "lists_users", id: false, force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "user_id", null: false
    t.index ["list_id", "user_id"], name: "index_lists_users_on_list_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_lists_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_users", id: false, force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.index ["followed_id"], name: "index_users_users_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_users_users_on_follower_id_and_followed_id", unique: true
  end

  add_foreign_key "list_items", "lists", on_delete: :cascade
  add_foreign_key "lists", "categories", on_delete: :restrict
  add_foreign_key "lists", "users", on_delete: :cascade
  add_foreign_key "lists_users", "lists"
  add_foreign_key "lists_users", "users"
  add_foreign_key "users_users", "users", column: "followed_id", on_delete: :cascade
  add_foreign_key "users_users", "users", column: "follower_id", on_delete: :cascade
end
