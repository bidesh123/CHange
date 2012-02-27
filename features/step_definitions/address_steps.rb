Given /^the following addresses:$/ do |addresses|
  Address.create!(addresses.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) address$/ do |pos|
  visit addresses_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end
 

Then /^I should see the following addresses:$/ do |expected_addresses_table|
  expected_addresses_table.diff!(tableish('table tr', 'td,th'))
end
