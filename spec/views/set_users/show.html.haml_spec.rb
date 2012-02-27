require 'spec_helper'

describe "set_users/show.html.haml" do
  before(:each) do
    @set_user = assign(:set_user, stub_model(SetUser))
  end

  it "renders attributes in <p>" do
    render
  end
end
