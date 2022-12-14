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

ActiveRecord::Schema.define(version: 2022_12_14_013130) do

  create_table "academic_years", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "from"
    t.integer "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest"
    t.string "first_name", null: false
    t.string "middle_name", null: false
    t.string "last_name", null: false
    t.string "suffix", default: ""
    t.string "gender", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "advices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "student_id"
    t.text "message"
    t.text "subject_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staff_id"], name: "index_advices_on_staff_id"
    t.index ["student_id"], name: "index_advices_on_student_id"
  end

  create_table "colleges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_colleges_on_code"
  end

  create_table "curriculums", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "code", null: false
    t.string "description"
    t.bigint "college_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.index ["code"], name: "index_curriculums_on_code"
    t.index ["college_id"], name: "index_curriculums_on_college_id"
    t.index ["department_id"], name: "index_curriculums_on_department_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "college_id"
    t.index ["college_id"], name: "index_departments_on_college_id"
  end

  create_table "enrollments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "enrolled_id", null: false
    t.bigint "student_id", null: false
    t.integer "sem", null: false
    t.string "grade", default: ""
    t.datetime "datetime_enrolled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "academic_year_id"
    t.index ["academic_year_id"], name: "index_enrollments_on_academic_year_id"
    t.index ["enrolled_id"], name: "index_enrollments_on_enrolled_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "description"
    t.bigint "college_id"
    t.bigint "curriculum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["college_id"], name: "index_majors_on_college_id"
    t.index ["curriculum_id"], name: "index_majors_on_curriculum_id"
  end

  create_table "prerequisites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "subject_prerequisite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id", default: 1
    t.index ["subject_id"], name: "index_prerequisites_on_subject_id"
    t.index ["subject_prerequisite_id"], name: "index_prerequisites_on_subject_prerequisite_id"
  end

  create_table "recommendations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "curriculum_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "semester"
    t.integer "year"
    t.index ["curriculum_id"], name: "index_recommendations_on_curriculum_id"
    t.index ["subject_id"], name: "index_recommendations_on_subject_id"
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest"
    t.string "first_name", null: false
    t.string "middle_name", null: false
    t.string "last_name", null: false
    t.string "suffix", default: ""
    t.string "gender", null: false
    t.bigint "college_id", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.boolean "is_dean", default: false
    t.index ["college_id"], name: "index_staffs_on_college_id"
    t.index ["department_id"], name: "index_staffs_on_department_id"
  end

  create_table "students", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest"
    t.string "first_name", null: false
    t.string "middle_name", null: false
    t.string "last_name", null: false
    t.string "suffix", default: ""
    t.string "gender", null: false
    t.string "id_number", null: false
    t.bigint "adviser_id", null: false
    t.bigint "college_id", null: false
    t.bigint "curriculum_id", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adviser_id"], name: "index_students_on_adviser_id"
    t.index ["college_id"], name: "index_students_on_college_id"
    t.index ["curriculum_id"], name: "index_students_on_curriculum_id"
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "code", null: false
    t.string "description"
    t.integer "units", null: false
    t.bigint "college_id"
    t.string "prerequisite_condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.boolean "ghost", default: false
    t.index ["code"], name: "index_subjects_on_code"
    t.index ["college_id"], name: "index_subjects_on_college_id"
    t.index ["department_id"], name: "index_subjects_on_department_id"
  end

  add_foreign_key "curriculums", "colleges"
  add_foreign_key "enrollments", "subjects", column: "enrolled_id"
  add_foreign_key "majors", "colleges"
  add_foreign_key "majors", "curriculums"
  add_foreign_key "prerequisites", "subjects"
  add_foreign_key "prerequisites", "subjects", column: "subject_prerequisite_id"
  add_foreign_key "recommendations", "curriculums"
  add_foreign_key "recommendations", "subjects"
  add_foreign_key "staffs", "colleges"
  add_foreign_key "staffs", "departments"
  add_foreign_key "students", "colleges"
  add_foreign_key "students", "curriculums"
  add_foreign_key "students", "staffs", column: "adviser_id"
  add_foreign_key "subjects", "colleges"
end
