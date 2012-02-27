require 'spec_helper'

describe "other_videos/show.html.haml" do
  before(:each) do
    @other_video = assign(:other_video, stub_model(OtherVideo))
  end

  it "renders attributes in <p>" do
    render
  end
end
