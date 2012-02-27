require 'spec_helper'

describe "set_roles/edit.html.haml" do
  before(:each) do
    @set_role = assign(:set_role, stub_model(SetRole))
  end

  it "renders the edit set_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => set_roles_path(@set_role), :method => "post" do
    end
  end
end
