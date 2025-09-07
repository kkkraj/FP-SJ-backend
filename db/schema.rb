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

ActiveRecord::Schema.define(version: 2025_09_07_201147) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "activity_name"
    t.string "activity_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "diary_entries", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "entry_date"
  end

  create_table "diary_photos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "diary_entry_id"
    t.date "photo_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diary_entry_id"], name: "index_diary_photos_on_diary_entry_id"
    t.index ["photo_date"], name: "index_diary_photos_on_photo_date"
    t.index ["user_id"], name: "index_diary_photos_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gratitudes", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "journal_prompts", force: :cascade do |t|
    t.text "question"
    t.string "category"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moods", force: :cascade do |t|
    t.string "mood_name"
    t.string "mood_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer "user_id"
    t.integer "activity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "activity_date"
    t.integer "duration"
  end

  create_table "user_goals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "goal_id", null: false
    t.date "date"
    t.boolean "completed"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_user_goals_on_goal_id"
    t.index ["user_id"], name: "index_user_goals_on_user_id"
  end

  create_table "user_gratitudes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "gratitude_id", null: false
    t.date "date"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gratitude_id"], name: "index_user_gratitudes_on_gratitude_id"
    t.index ["user_id"], name: "index_user_gratitudes_on_user_id"
  end

  create_table "user_moods", force: :cascade do |t|
    t.integer "user_id"
    t.integer "mood_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "mood_date"
  end

  create_table "user_prompt_responses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "journal_prompt_id", null: false
    t.date "date"
    t.text "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["journal_prompt_id"], name: "index_user_prompt_responses_on_journal_prompt_id"
    t.index ["user_id"], name: "index_user_prompt_responses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "diary_photos", "diary_entries"
  add_foreign_key "diary_photos", "users"
  add_foreign_key "user_goals", "goals"
  add_foreign_key "user_goals", "users"
  add_foreign_key "user_gratitudes", "gratitudes"
  add_foreign_key "user_gratitudes", "users"
  add_foreign_key "user_prompt_responses", "journal_prompts"
  add_foreign_key "user_prompt_responses", "users"
end
