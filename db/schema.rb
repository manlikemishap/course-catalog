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

ActiveRecord::Schema.define(version: 20150118061409) do

  create_table "components", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.integer  "course_id",  limit: 4
    t.string   "days",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "williams_id",         limit: 6
    t.string   "semester",            limit: 255
    t.string   "offered",             limit: 255
    t.string   "last_offered",        limit: 255
    t.string   "title",               limit: 255
    t.boolean  "d",                   limit: 1
    t.boolean  "w",                   limit: 1
    t.boolean  "q",                   limit: 1
    t.text     "description",         limit: 65535
    t.string   "format",              limit: 50
    t.string   "eval",                limit: 255
    t.string   "prereqs",             limit: 255
    t.string   "preferences",         limit: 255
    t.integer  "enrollment_limit",    limit: 4
    t.integer  "expected_enrollment", limit: 4
    t.string   "department_notes",    limit: 255
    t.string   "distribution_notes",  limit: 255
    t.string   "extra_info",          limit: 255
    t.string   "extra_info_2",        limit: 255
    t.string   "fees",                limit: 255
    t.string   "attrs",               limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "courses_professors", force: :cascade do |t|
    t.integer "course_id",    limit: 4
    t.integer "professor_id", limit: 4
  end

  create_table "departments", force: :cascade do |t|
    t.integer  "division",     limit: 4
    t.string   "name",         limit: 255
    t.string   "abbreviation", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "professors", force: :cascade do |t|
    t.integer  "department_id", limit: 4
    t.string   "name",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.string   "days",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
