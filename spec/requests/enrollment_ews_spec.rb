require 'rails_helper'

RSpec.describe "EnrollmentEws", type: :request do
  describe "GET /enrollment_ews" do
    it "works! (now write some real specs)" do
      get enrollment_ews_path
      expect(response).to have_http_status(200)
    end
  end
end
