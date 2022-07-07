require "rails_helper"

RSpec.describe EnrollmentEwsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/enrollment_ews").to route_to("enrollment_ews#index")
    end

    it "routes to #show" do
      expect(:get => "/enrollment_ews/1").to route_to("enrollment_ews#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/enrollment_ews").to route_to("enrollment_ews#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/enrollment_ews/1").to route_to("enrollment_ews#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/enrollment_ews/1").to route_to("enrollment_ews#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/enrollment_ews/1").to route_to("enrollment_ews#destroy", :id => "1")
    end
  end
end
