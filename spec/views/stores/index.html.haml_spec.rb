require 'spec_helper'

describe "stores/index.html.haml" do
  before(:each) do
    assign(:stores, [
      stub_model(Store,
        :user_id => 1,
        :description => "MyText",
        :title => "Title"
      ),
      stub_model(Store,
        :user_id => 1,
        :description => "MyText",
        :title => "Title"
      )
    ])
  end

  it "renders a list of stores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
