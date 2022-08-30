class AcademicYear < ApplicationRecord
      has_many :academic_years
      validates :from, presence: true
      validates :to, presence: true
end
