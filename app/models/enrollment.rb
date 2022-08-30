class Enrollment < ApplicationRecord
    belongs_to :student, class_name: "Student"
    belongs_to :enrolled, class_name: "Subject"
    belongs_to :academic_year

    validates :enrolled_id, presence: true, uniqueness: true
end
