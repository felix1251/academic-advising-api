class Enrollment < ApplicationRecord
    belongs_to :student, class_name: "Student"
    belongs_to :enrolled, class_name: "Subject"

    validates :enrolled_id, presence: true, uniqueness: true
end
