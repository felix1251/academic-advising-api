class Student < ApplicationRecord
      include ActiveModel::Serializers::JSON
      has_secure_password
      belongs_to :adviser, class_name: "Staff"
      belongs_to :college
      belongs_to :curriculum
      has_many :enrollments
      enum gender: {male: "male", female: "female"}

      # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
      validates :username, presence: true, uniqueness: { case_sensitive: false }
end
