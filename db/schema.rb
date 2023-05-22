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

ActiveRecord::Schema[7.0].define(version: 2023_05_22_045700) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapters", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "course_id", null: false
    t.string "title", null: false
    t.string "status", default: "draft"
    t.integer "position", default: 1
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "title"], name: "index_chapters_on_course_id_and_title", unique: true
    t.index ["course_id"], name: "index_chapters_on_course_id"
    t.index ["organization_id"], name: "index_chapters_on_organization_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "status", default: "draft"
    t.string "currency"
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.integer "validity", default: 365
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "slug"], name: "index_courses_on_organization_id_and_slug", unique: true
    t.index ["organization_id"], name: "index_courses_on_organization_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "student"
    t.boolean "active", default: true
    t.datetime "enrolled_on"
    t.datetime "valid_till"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "order_required", default: true
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["organization_id", "user_id"], name: "index_enrollments_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_enrollments_on_organization_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "course_id", null: false
    t.bigint "chapter_id"
    t.string "title", null: false
    t.string "status", default: "draft"
    t.integer "position", default: 1
    t.text "description"
    t.string "type", default: "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id", "title"], name: "index_lessons_on_chapter_id_and_title", unique: true
    t.index ["chapter_id"], name: "index_lessons_on_chapter_id"
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["organization_id"], name: "index_lessons_on_organization_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "course_id"
    t.bigint "user_id"
    t.string "slug", null: false
    t.string "source", default: "user"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "discount", default: 0
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "status", default: "initiated"
    t.string "payment_status", default: "due"
    t.string "payment_id"
    t.string "payment_gateway"
    t.boolean "paid", default: false
    t.integer "billed_enrollment_count"
    t.datetime "billing_start_date"
    t.datetime "billing_end_date"
    t.datetime "due_date"
    t.json "billing_address"
    t.json "user_details"
    t.json "course_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_orders_on_course_id"
    t.index ["organization_id"], name: "index_orders_on_organization_id"
    t.index ["slug"], name: "index_orders_on_slug", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "status", default: "active"
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "courses_count", default: 0
    t.integer "users_count", default: 0
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "email", null: false
    t.string "full_name"
    t.string "password_digest"
    t.string "phone"
    t.string "role", default: "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "email"], name: "index_users_on_organization_id_and_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  add_foreign_key "chapters", "courses"
  add_foreign_key "chapters", "organizations"
  add_foreign_key "courses", "organizations"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "organizations"
  add_foreign_key "enrollments", "users"
  add_foreign_key "lessons", "chapters"
  add_foreign_key "lessons", "courses"
  add_foreign_key "lessons", "organizations"
  add_foreign_key "orders", "courses"
  add_foreign_key "orders", "organizations"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "organizations"
end
