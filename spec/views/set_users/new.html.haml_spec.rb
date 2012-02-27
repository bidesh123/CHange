require 'spec_helper'

describe "set_users/new.html.haml" do
  before(:each) do
    assign(:set_user, stub_model(SetUser).as_new_record)
  end

  it "renders new set_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => set_users_path, :method => "post" do
    end
  end
end
