require 'spec_helper'

describe "SetRoles" do
  describe "GET /set_roles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get set_roles_path
      response.status.should be(200)
    end
  end
end
