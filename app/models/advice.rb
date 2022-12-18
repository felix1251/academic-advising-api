class Advice < ApplicationRecord
      serialize :subject_ids, Array
      has_many :students
      enum sender: {S: "S", F: "F"}
end
