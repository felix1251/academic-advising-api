require "rails_helper"

RSpec.describe AdvicesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/advices").to route_to("advices#index")
    end

    it "routes to #show" do
      expect(:get => "/advices/1").to route_to("advices#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/advices").to route_to("advices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/advices/1").to route_to("advices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/advices/1").to route_to("advices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/advices/1").to route_to("advices#destroy", :id => "1")
    end
  end
end
