require 'spec_helper'

describe "set_roles/show.html.haml" do
  before(:each) do
    @set_role = assign(:set_role, stub_model(SetRole))
  end

  it "renders attributes in <p>" do
    render
  end
end
