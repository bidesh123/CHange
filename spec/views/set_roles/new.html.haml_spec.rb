require 'spec_helper'

describe "set_roles/new.html.haml" do
  before(:each) do
    assign(:set_role, stub_model(SetRole).as_new_record)
  end

  it "renders new set_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => set_roles_path, :method => "post" do
    end
  end
end
