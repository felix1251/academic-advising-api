class Enrollment < ApplicationRecord
    belongs_to :student, class_name: "Student"
    belongs_to :enrolled, class_name: "Subject"
    belongs_to :academic_year

    validates :enrolled_id, presence: true, uniqueness: true
    validates :check_grade

    def check_grade
        list_a = ["INC", "P", "DRP", "3"]
        list_b = ["1", "1.25", "1.5", "1.75"]
        list_c = ["2", "2.25", "2.5", "2.75"]
        list = list_a + list_b + list_c

        unless list.include?(self.grade)
            errors.add(:grade, "invalid grade")
        end
    end
end
