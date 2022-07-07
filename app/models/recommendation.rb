class Recommendation < ApplicationRecord
    belongs_to :subject
    belongs_to :curriculum
end
