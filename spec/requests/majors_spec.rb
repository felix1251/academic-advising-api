require 'rails_helper'

RSpec.describe "Majors", type: :request do
  describe "GET /majors" do
    it "works! (now write some real specs)" do
      get majors_path
      expect(response).to have_http_status(200)
    end
  end
end
