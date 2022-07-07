class Prerequisite < ApplicationRecord
    belongs_to :subject 
    belongs_to :subject_prerequisite, class_name: "Subject"
end