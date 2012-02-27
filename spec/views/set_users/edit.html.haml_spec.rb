require 'spec_helper'

describe "set_users/edit.html.haml" do
  before(:each) do
    @set_user = assign(:set_user, stub_model(SetUser))
  end

  it "renders the edit set_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => set_users_path(@set_user), :method => "post" do
    end
  end
end
