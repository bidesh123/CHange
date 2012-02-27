require 'spec_helper'

describe "other_videos/index.html.haml" do
  before(:each) do
    assign(:other_videos, [
      stub_model(OtherVideo),
      stub_model(OtherVideo)
    ])
  end

  it "renders a list of other_videos" do
    render
  end
end
