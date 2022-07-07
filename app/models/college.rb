class College < ApplicationRecord
    has_many :curriculums
    has_many :subjects
    has_many :users
    has_many :departments

    validates :code, presence: true, uniqueness: true, length: { maximum: 10, too_long: "%{count} characters is the maximum allowed" }
end
