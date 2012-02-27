require 'spec_helper'

describe "other_videos/new.html.haml" do
  before(:each) do
    assign(:other_video, stub_model(OtherVideo).as_new_record)
  end

  it "renders new other_video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => other_videos_path, :method => "post" do
    end
  end
end
