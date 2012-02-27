require 'spec_helper'

describe "set_users/index.html.haml" do
  before(:each) do
    assign(:set_users, [
      stub_model(SetUser),
      stub_model(SetUser)
    ])
  end

  it "renders a list of set_users" do
    render
  end
end
