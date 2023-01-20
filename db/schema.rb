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

ActiveRecord::Schema[7.0].define(version: 2023_01_20_135304) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.datetime "arrival_time"
    t.datetime "left_time"
    t.float "total_price"
    t.string "ref_code"
    t.string "license_plate"
    t.bigint "slot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slot_id"], name: "index_bookings_on_slot_id"
  end

  create_table "parkings", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "open_time"
    t.datetime "close_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "from"
    t.datetime "to"
    t.string "total_price"
    t.string "slot_type"
    t.bigint "slot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.integer "number_of_hours", default: 1
    t.index ["slot_id"], name: "index_reservations_on_slot_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "name", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "slot_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parking_id", null: false
    t.index ["parking_id"], name: "index_slot_types_on_parking_id"
  end

  create_table "slots", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "open_time"
    t.datetime "close_time"
    t.integer "status", default: 0
    t.bigint "slot_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slot_type_id"], name: "index_slots_on_slot_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "bookings", "slots"
  add_foreign_key "reservations", "slots"
  add_foreign_key "slot_types", "parkings"
  add_foreign_key "slots", "slot_types"
  add_foreign_key "users", "roles"
end
