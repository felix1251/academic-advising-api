class Admin < ApplicationRecord
      include ActiveModel::Serializers::JSON
      has_secure_password
      validates :username, presence: true, uniqueness: { case_sensitive: false }
      enum gender: {male: "male", female: "female"}
      
      def attributes
            { id: id, first_name: first_name, middle_name: middle_name, last_name: last_name, gender: gender, status: status}
      end
end
