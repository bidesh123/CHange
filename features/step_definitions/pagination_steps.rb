Given /^the following paginations:$/ do |paginations|
  Pagination.create!(paginations.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) pagination$/ do |pos|
  visit paginations_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following paginations:$/ do |expected_paginations_table|
  expected_paginations_table.diff!(tableish('table tr', 'td,th'))
end


Given /^I have (\d+) videos$/ do |arg1|
  if Video.all.size == arg1 || Asset.all(:assetable_type => "video").size == arg1
    true
  end
end

When /^I view all videos$/ do
  visit path_to("the store wise list path")
end

Then /^I should see "([^"]*)" on the page$/ do |arg1|
  

end



Given /^I have <count> videos$/ do
  Asset.all(:assetable_type => "video").count
end

When /^I view all videos from page "([^"]*)"$/ do |page1|
  Video.all(:limit => 2)
end



Then /^I should see a link "([^"]*)"$/ do |arg1|
  
end

When /^I click "([^"]*)"$/ do |arg1|
  click_link(arg1)
end

When /^I view all videos from page <page>$/ do
  visit path_to("the store desc page 1")
end


Then /^I should see a disabled pagination link "([^"]*)"$/ do |arg1|
 
end


Then /^I should see a disabled pagination link to page "([^"]*)"$/ do |link|
  attributes = find_field("next").node.attributes.keys
  attributes.send(negate ? :should_not : :should, include('disabled'))
end