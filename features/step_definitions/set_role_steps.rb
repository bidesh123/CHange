Given /^the following set_roles:$/ do |set_roles|
  SetRole.create!(set_roles.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) set_role$/ do |pos|
  visit set_roles_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Given /^I have one admin user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  @user = Factory(:user, :email => email, :password => password, :password_confirmation => password, :confirmed_at => Time.now, :confirmation_sent_at => Time.now)
  @user.roles << Role.first(:name => "admin")
end

Given /^I am an authenticated admin user$/ do
  email = 'admin@lostbets.com'
  password = 'arminus'
  Given %{I have one admin user "#{email}" with password "#{password}"}
  user=User.first(:email => email)
  RoleUser.create(:user_id => user.id, :role_id => 1 ) if RoleUser.first(:user_id => user.id).nil?
  And %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
  visit path_to("the my account page")
end


Then /^I set the role of the user to "([^"]*)"$/ do |role|
  role_user=RoleUser.first
  role_user.update(:role_id => Role.first(:name => role).id, :user_id => User.first.id)
end

Then /^I should see the following set_roles:$/ do |expected_set_roles_table|
  expected_set_roles_table.diff!(tableish('table tr', 'td,th'))
end
