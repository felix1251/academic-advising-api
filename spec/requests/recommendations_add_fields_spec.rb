require 'rails_helper'

RSpec.describe "RecommendationsAddFields", type: :request do
  describe "GET /recommendations_add_fields" do
    it "works! (now write some real specs)" do
      get recommendations_add_fields_path
      expect(response).to have_http_status(200)
    end
  end
end
