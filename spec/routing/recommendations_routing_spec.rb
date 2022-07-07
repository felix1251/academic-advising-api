require "rails_helper"

RSpec.describe RecommendationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/recommendations").to route_to("recommendations#index")
    end

    it "routes to #show" do
      expect(:get => "/recommendations/1").to route_to("recommendations#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/recommendations").to route_to("recommendations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/recommendations/1").to route_to("recommendations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/recommendations/1").to route_to("recommendations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/recommendations/1").to route_to("recommendations#destroy", :id => "1")
    end
  end
end
