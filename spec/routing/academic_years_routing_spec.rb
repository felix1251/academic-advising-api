require "rails_helper"

RSpec.describe AcademicYearsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/academic_years").to route_to("academic_years#index")
    end

    it "routes to #show" do
      expect(:get => "/academic_years/1").to route_to("academic_years#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/academic_years").to route_to("academic_years#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/academic_years/1").to route_to("academic_years#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/academic_years/1").to route_to("academic_years#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/academic_years/1").to route_to("academic_years#destroy", :id => "1")
    end
  end
end
