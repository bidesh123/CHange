require 'spec_helper'

describe "pictures/index.html.haml" do
  before(:each) do
    assign(:pictures, [
      stub_model(Picture),
      stub_model(Picture)
    ])
  end

  it "renders a list of pictures" do
    render
  end
end
