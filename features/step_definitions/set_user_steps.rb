Given /^the following set_users:$/ do |set_users|
  SetUser.create!(set_users.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) set_user$/ do |pos|
  visit set_users_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^Admin has changed the Firstname as "([^"]*)"$/ do |firstname|
  u=User.first
  u.update(:first_name => firstname)
end

Then /^Admin has changed the email as "([^"]*)"$/ do |email|
  u=User.first
  u.update(:email => email)
  
end

Then /^Admin redirect to the admin set user show path$/ do
  visit path_to("the admin set user show path")
end

Then /^Admin destroy the (\d+)rd user$/ do |id|
  user=User.get(id)
  user.role_users.all.destroy unless user.role_users.empty?
  user.destroy
end




Then /^I should see the following set_users:$/ do |expected_set_users_table|
  expected_set_users_table.diff!(tableish('table tr', 'td,th'))
end
