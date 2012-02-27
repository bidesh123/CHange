require 'spec_helper'

describe "stores/edit.html.haml" do
  before(:each) do
    @store = assign(:store, stub_model(Store,
      :user_id => 1,
      :description => "MyText",
      :title => "MyString"
    ))
  end

  it "renders the edit store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stores_path(@store), :method => "post" do
      assert_select "input#store_user_id", :name => "store[user_id]"
      assert_select "textarea#store_description", :name => "store[description]"
      assert_select "input#store_title", :name => "store[title]"
    end
  end
end
