Given /^the following texts:$/ do |texts|
  Text.create!(texts.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) text$/ do |pos|
  visit texts_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end


And /^I fill the text form with body "([^"]*)" and title "([^"]*)" and save it$/ do |body,title|
   content=Factory(:text, :title => title, :body => body, :updated_at => Time.now) if Text.first.nil?
end


And /^I edit the content of id "([^"]*)" fill the text form with body "([^"]*)" and title "([^"]*)" and save it$/ do |id, body, title|
  content = Text.get(id)
  content.update(:body => body, :title => title)
end

Then /^It is also update Asset table$/ do
  content=Text.first unless Text.first.nil?
  store=Store.first unless Store.first.nil?
  Asset.create(:assetable_id => 1, :assetable_type => "text", :store_id => 1)
end

Then /^I delete the text from the list$/ do
  unless Text.first.nil?
    content=Text.first
    content.destroy
  end
end

Then /^I should see the following texts:$/ do |expected_texts_table|
  expected_texts_table.diff!(tableish('table tr', 'td,th'))
end
