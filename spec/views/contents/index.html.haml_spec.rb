require 'spec_helper'

describe "contents/index.html.haml" do
  before(:each) do
    assign(:contents, [
      stub_model(Content),
      stub_model(Content)
    ])
  end

  it "renders a list of contents" do
    render
  end
end
