require 'spec_helper'

describe "contents/show.html.haml" do
  before(:each) do
    @content = assign(:content, stub_model(Content))
  end

  it "renders attributes in <p>" do
    render
  end
end
