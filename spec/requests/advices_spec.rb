require 'rails_helper'

RSpec.describe "Advices", type: :request do
  describe "GET /advices" do
    it "works! (now write some real specs)" do
      get advices_path
      expect(response).to have_http_status(200)
    end
  end
end
