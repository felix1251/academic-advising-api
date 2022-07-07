class Curriculum < ApplicationRecord
    belongs_to :college
    has_many :subjects
    has_many :users
    
    validates :code, presence: true, uniqueness: true, length: { maximum: 10, too_long: "%{count} characters is the maximum allowed" }
end
