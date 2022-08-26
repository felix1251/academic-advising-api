class Staff < ApplicationRecord
      include ActiveModel::Serializers::JSON
      has_secure_password
      belongs_to :college
      belongs_to :curriculum
      validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
      validates :username, presence: true, uniqueness: { case_sensitive: false }
      enum role: {male: "male", female: "female"}

      def attributes
            { id: id, email: email, first_name: first_name, middle_name: middle_name, last_name: last_name, 
            gender: gender, status: status, college_id: college_id, curriculum_id: curriculum_id}
      end
end
