class Staff < ApplicationRecord
      include ActiveModel::Serializers::JSON
      has_secure_password
      belongs_to :college
      belongs_to :department
      has_many :students
      # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
      validates :username, presence: true, uniqueness: { case_sensitive: false }
      enum gender: {male: "male", female: "female"}

      def attributes
            super.except('password_digest', 'reset_password_token', 'reset_password_token_expires_at')
      end
end
