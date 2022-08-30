require 'rails_helper'

RSpec.describe "AcademicYears", type: :request do
  describe "GET /academic_years" do
    it "works! (now write some real specs)" do
      get academic_years_path
      expect(response).to have_http_status(200)
    end
  end
end
