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

ActiveRecord::Schema.define(version: 2021_07_06_052644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "business_hours", force: :cascade do |t|
    t.integer "day"
    t.time "open_at"
    t.time "close_at"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_business_hours_on_restaurant_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.datetime "date"
    t.bigint "user_id", null: false
    t.bigint "restaurant_id", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_purchases_on_menu_id"
    t.index ["restaurant_id"], name: "index_purchases_on_restaurant_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.decimal "balance", precision: 8, scale: 2
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.decimal "balance", precision: 8, scale: 2
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "business_hours", "restaurants"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "purchases", "menus"
  add_foreign_key "purchases", "restaurants"
  add_foreign_key "purchases", "users"
end
