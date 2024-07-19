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

ActiveRecord::Schema[7.1].define(version: 2024_07_13_015228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customizations", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customizations_purchases", id: false, force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.bigint "customization_id", null: false
    t.index ["customization_id", "purchase_id"], name: "idx_on_customization_id_purchase_id_a60cec465b"
    t.index ["purchase_id", "customization_id"], name: "idx_on_purchase_id_customization_id_14cb4ef358"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "receiver"
    t.date "day"
    t.string "address"
    t.string "number"
    t.string "schedules"
    t.string "cost"
    t.bigint "purchase_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_destinations_on_purchase_id"
  end

  create_table "gift_categorizations", force: :cascade do |t|
    t.bigint "gift_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_gift_categorizations_on_category_id"
    t.index ["gift_id"], name: "index_gift_categorizations_on_gift_id"
  end

  create_table "gift_customizations", force: :cascade do |t|
    t.bigint "gift_id", null: false
    t.bigint "customization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customization_id"], name: "index_gift_customizations_on_customization_id"
    t.index ["gift_id"], name: "index_gift_customizations_on_gift_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.float "valoration"
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_gifts_on_supplier_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.string "owner"
    t.string "card_number"
    t.date "due_date"
    t.string "CVV"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payment_methods_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "RUT"
    t.string "social_reason"
    t.integer "price"
    t.bigint "payment_method_id", null: false
    t.bigint "gift_id", null: false
    t.boolean "suprise_delivery"
    t.string "personalization"
    t.boolean "resend_delivery"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount"
    t.integer "subtotal"
    t.index ["gift_id"], name: "index_purchases_on_gift_id"
    t.index ["payment_method_id"], name: "index_purchases_on_payment_method_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "last_name"
    t.string "company_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "customizations_purchases", "customizations"
  add_foreign_key "customizations_purchases", "purchases"
  add_foreign_key "destinations", "purchases"
  add_foreign_key "gift_categorizations", "categories"
  add_foreign_key "gift_categorizations", "gifts"
  add_foreign_key "gift_customizations", "customizations"
  add_foreign_key "gift_customizations", "gifts"
  add_foreign_key "gifts", "suppliers"
  add_foreign_key "payment_methods", "users"
  add_foreign_key "purchases", "gifts"
  add_foreign_key "purchases", "payment_methods"
end
