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

ActiveRecord::Schema.define(version: 2022_07_26_064754) do

  create_table "admins", force: :cascade do |t|
    t.string "password_digest"
    t.string "first_name", null: false
    t.string "middle_name", null: false
    t.string "last_name", null: false
    t.string "suffix", default: ""
    t.string "gender", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "username"
  end

  create_table "colleges", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_colleges_on_code"
  end

  create_table "curriculums", force: :cascade do |t|
    t.string "code", null: false
    t.string "description"
    t.integer "college_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.index ["code"], name: "index_curriculums_on_code"
    t.index ["college_id"], name: "index_curriculums_on_college_id"
    t.index ["department_id"], name: "index_curriculums_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "college_id"
    t.index ["college_id"], name: "index_departments_on_college_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "enrolled_id", null: false
    t.integer "sem", null: false
    t.datetime "datetime_enrolled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "grade", default: ""
    t.integer "student_id"
    t.index ["enrolled_id"], name: "index_enrollments_on_enrolled_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string "description"
    t.integer "college_id"
    t.integer "curriculum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["college_id"], name: "index_majors_on_college_id"
    t.index ["curriculum_id"], name: "index_majors_on_curriculum_id"
  end

  create_table "prerequisites", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "subject_prerequisite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id", default: 1
    t.index ["subject_id"], name: "index_prerequisites_on_subject_id"
    t.index ["subject_prerequisite_id"], name: "index_prerequisites_on_subject_prerequisite_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "curriculum_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "semester"
    t.integer "year"
    t.index ["curriculum_id"], name: "index_recommendations_on_curriculum_id"
    t.index ["subject_id"], name: "index_recommendations_on_subject_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "password_digest"
    t.string "first_name", null: false
    t.string "middle_name", null: false
    t.string "last_name", null: false
    t.string "suffix", default: ""
    t.string "gender", null: false
    t.integer "college_id", null: false
    t.integer "curriculum_id"
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "username"
    t.boolean "dean", default: false
    t.index ["college_id"], name: "index_staffs_on_college_id"
    t.index ["curriculum_id"], name: "index_staffs_on_curriculum_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "password_digest"
    t.string "first_name", null: false
    t.string "middle_name", null: false
    t.string "last_name", null: false
    t.string "suffix", default: ""
    t.string "gender", null: false
    t.integer "college_id", null: false
    t.integer "curriculum_id", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "username"
    t.integer "id_number", null: false
    t.integer "adviser_id", null: false
    t.index ["adviser_id"], name: "index_students_on_adviser_id"
    t.index ["college_id"], name: "index_students_on_college_id"
    t.index ["curriculum_id"], name: "index_students_on_curriculum_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "code", null: false
    t.string "description"
    t.integer "units", null: false
    t.integer "college_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.string "prerequisite_condition"
    t.index ["code"], name: "index_subjects_on_code"
    t.index ["college_id"], name: "index_subjects_on_college_id"
    t.index ["department_id"], name: "index_subjects_on_department_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "password_digest"
    t.string "fullname", null: false
    t.boolean "status", default: true
    t.integer "college_id"
    t.integer "curriculum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.integer "id_number"
    t.index ["college_id"], name: "index_users_on_college_id"
    t.index ["curriculum_id"], name: "index_users_on_curriculum_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

end
