require 'spec_helper'

describe "other_videos/edit.html.haml" do
  before(:each) do
    @other_video = assign(:other_video, stub_model(OtherVideo))
  end

  it "renders the edit other_video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => other_videos_path(@other_video), :method => "post" do
    end
  end
end
