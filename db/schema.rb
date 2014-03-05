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

ActiveRecord::Schema.define(version: 20140303225125) do

  create_table "announcements", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content"
  end

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "image_url"
    t.string   "good_example"
    t.string   "bad_example"
  end

  create_table "courses", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id"

  create_table "courses_users", id: false, force: true do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  create_table "questions", force: true do |t|
    t.string   "image_url"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "example2"
    t.string   "good_example"
    t.string   "bad_example"
  end

  create_table "responses", force: true do |t|
    t.string   "sentence1"
    t.string   "sentence2"
    t.string   "sentence3"
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "reviewer_id"
    t.string   "revised_sentence1"
    t.string   "revised_sentence2"
    t.string   "revised_sentence3"
    t.integer  "best_sentence"
    t.integer  "worst_sentence"
    t.string   "best_sentence_feedback"
    t.string   "worst_sentence_feedback"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["user_id"], name: "index_responses_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
  end

end
