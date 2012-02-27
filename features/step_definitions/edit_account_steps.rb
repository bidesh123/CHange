Given /^I edit my account as "([^"]*)" with "([^"]*)"$/ do |field, value|
  visit path_to("the my account page")
  fill_in(field, :with => value)
end


When /^I visit to the my account page$/ do
  visit path_to("the my account page")
end


Then /^I fill up the my account page form$/ do
  Given %{I am an authenticated user}
  visit path_to("the my account page")
  fill_in(:Email, :with => 'producer@lostbets.com')
  fill_in(:Password, :with => 'arminus')
  fill_in(:user_password_confirmation, :with => 'arminus')
  fill_in(:user_current_password, :with => 'new password')
  Then %{I am on the my account page}
#  page.should have_content("Sign out")
#  click_button("Update Account")
end

Then /^I am updated my account successfully$/ do
    visit path_to("the home page")
end

Given /^I am an authenticated user$/ do
 
  @user = Factory(:user)
  @user.confirm!
  @user.update_attribute(:current_sign_in_at, Time.now.to_s)
  @user.update_attribute(:last_sign_in_at, Time.now.to_s)
  @user.update_attribute(:sign_in_count, 1)
end


Then /^I should see the following edit_accounts:$/ do |expected_edit_accounts_table|
  expected_edit_accounts_table.diff!(tableish('table tr', 'td,th'))
end
