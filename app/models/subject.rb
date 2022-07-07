class Subject < ApplicationRecord
    belongs_to :college 
    belongs_to :curriculum, optional: true
    
    has_many :prerequisites

    # enum prerequisite_condition: %i[AND OR NONE].freeze

    validates :code, presence: true, uniqueness: true, length: { maximum: 10, too_long: "%{count} characters is the maximum allowed" }
end
