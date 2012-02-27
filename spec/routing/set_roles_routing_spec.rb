require "spec_helper"

describe SetRolesController do
  describe "routing" do

    it "routes to #index" do
      get("/set_roles").should route_to("set_roles#index")
    end

    it "routes to #new" do
      get("/set_roles/new").should route_to("set_roles#new")
    end

    it "routes to #show" do
      get("/set_roles/1").should route_to("set_roles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/set_roles/1/edit").should route_to("set_roles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/set_roles").should route_to("set_roles#create")
    end

    it "routes to #update" do
      put("/set_roles/1").should route_to("set_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/set_roles/1").should route_to("set_roles#destroy", :id => "1")
    end

  end
end
