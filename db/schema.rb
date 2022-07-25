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

ActiveRecord::Schema[7.0].define(version: 2022_07_11_132942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_items_on_supplier_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "item_id"
    t.integer "price"
    t.string "status", default: "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "status"], name: "index_prices_on_item_id_and_status"
    t.index ["item_id", "status"], name: "unique_active_index_prices_on_item_id_and_status", unique: true, where: "((status)::text = 'current'::text)"
    t.index ["status"], name: "index_prices_on_status"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
