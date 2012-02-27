require 'spec_helper'

describe "home/index.html.haml" do
  include HomeHelper
  it "should display the home page." do
    render
  end
end
