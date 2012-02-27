require 'spec_helper'

describe "set_roles/index.html.haml" do
  before(:each) do
    assign(:set_roles, [
      stub_model(SetRole),
      stub_model(SetRole)
    ])
  end

  it "renders a list of set_roles" do
    render
  end
end
