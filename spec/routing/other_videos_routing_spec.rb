require "spec_helper"

describe OtherVideosController do
  describe "routing" do

    it "routes to #index" do
      get("/other_videos").should route_to("other_videos#index")
    end

    it "routes to #new" do
      get("/other_videos/new").should route_to("other_videos#new")
    end

    it "routes to #show" do
      get("/other_videos/1").should route_to("other_videos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/other_videos/1/edit").should route_to("other_videos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/other_videos").should route_to("other_videos#create")
    end

    it "routes to #update" do
      put("/other_videos/1").should route_to("other_videos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/other_videos/1").should route_to("other_videos#destroy", :id => "1")
    end

  end
end
