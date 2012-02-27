require "spec_helper"

describe SetUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/set_users").should route_to("set_users#index")
    end

    it "routes to #new" do
      get("/set_users/new").should route_to("set_users#new")
    end

    it "routes to #show" do
      get("/set_users/1").should route_to("set_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/set_users/1/edit").should route_to("set_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/set_users").should route_to("set_users#create")
    end

    it "routes to #update" do
      put("/set_users/1").should route_to("set_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/set_users/1").should route_to("set_users#destroy", :id => "1")
    end

  end
end
