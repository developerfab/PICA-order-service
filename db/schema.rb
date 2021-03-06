# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_26_195403) do

  create_table "order_products", force: :cascade do |t|
    t.integer "product_id"
    t.decimal "value", precision: 18, scale: 0
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "client_id"
    t.decimal "total", precision: 18, scale: 0
    t.string "status", default: "pending"
    t.string "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "payment_method"
    t.string "credit_number_card"
  end

  add_foreign_key "order_products", "orders"
end
