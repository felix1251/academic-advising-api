require "rails_helper"

RSpec.describe RecommendationsAddFieldsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/recommendations_add_fields").to route_to("recommendations_add_fields#index")
    end

    it "routes to #show" do
      expect(:get => "/recommendations_add_fields/1").to route_to("recommendations_add_fields#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/recommendations_add_fields").to route_to("recommendations_add_fields#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/recommendations_add_fields/1").to route_to("recommendations_add_fields#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/recommendations_add_fields/1").to route_to("recommendations_add_fields#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/recommendations_add_fields/1").to route_to("recommendations_add_fields#destroy", :id => "1")
    end
  end
end
