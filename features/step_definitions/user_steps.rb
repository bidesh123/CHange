Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit users_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

When /^I go to the signup page$/ do |page|
  visit users_path
end

And /^I fill in "([^"]*)" with "([^"]*)"$/ do |field,value|
  fill_in(field, :with => value)
end

Then /^I should see error messages$/ do 
  visit path_to("the sign in page")
end

And /^I fill the form for forgot password using my email "([^"]*)"$/ do |value|
  fill_in(:Email, :with => value)
  click_button("Send me reset password instructions")
  visit path_to("the sign in page")
end

Given /^I sign in as "([^"]*)"$/ do |value|
  @user= Factory(:user)
  @user = Factory(:user, :current_sign_in_at => Time.now.to_date,:last_sign_in_at => Time.now.to_date )
  @session={}
  @session["warden.user.user.key"] = [@user.class, @user.id]

  visit path_to("the sign in page")
  fill_in(:Email, :with => value.split("/").first)
  fill_in(:Password, :with => value.split("/").last)

  click_button("Sign in")
end

%w{notice success error}.each do |selector|
  Then /^(?:|I )should see #{selector} flash message "([^"]*)"$/ do |message|
    visit path_to("the home page")
  end
end

Given /^I am signed up as "(.+)\/(.+)"$/ do |email, password|
  #    User.new(:email => email, :password => password, :password_confirmation => password).save!
  Factory(:user, :email => email, :password => password, :password_confirmation => password)
end

Given /^I am logged out$/ do
  begin
    click_link("Sign out")
  rescue Capybara::ElementNotFound
  end
end

Then /^I should be logged in$/ do
  page.should_not have_content("Sign In")
end

Then /^I should be logged out$/ do
  visit path_to("the home page")
  page.should have_content("Login")
end


And /^Set the role of user as "([^"]*)"$/ do |role|
  xpath = %{//input[@type="hidden" and @name="type"]}
  page.find(:xpath, xpath).set(role)
  role = Role.first
  user=Factory(:user)
  user.roles << role
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.diff!(tableish('table tr', 'td,th'))
end



Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I have one user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  @user = Factory.create(:user, :password => password, :email => email)
  @user.roles << Role.first(:name => "producer")
end

Given /^I am a new, authenticated user$/ do
  
  email = 'producer@lostbets.com'
  password = 'arminus'
  Given %{I have one user "#{email}" with password "#{password}"}
  user=User.first(:email => email)
  RoleUser.create(:user_id => user.id, :role_id => 2 ) if RoleUser.first(:user_id => user.id).nil?

  
  And %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}

  visit path_to("the my account page")
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Sign Up"}
  And %{I should see "Login"}
  And %{I should not see "Sign out"}
end


Then /^(?:I|they) should receive an email with a link to a confirmation page$/ do
  unread_emails_for("producer@lostbets.com").size.should == 1
  # this call will store the email and you can access it with current_email
  open_last_email_for(last_email_address)
  current_email.should have_subject(/Reset password instructions/)
  current_email.should have_body_text('Hello producer@lostbets.com!')

end

And /^I should see "([^\"]*)" in the subject$/ do |text|
  current_email.should have_subject(/text/)
end

Then /^I should see "([^\"]*)" in the email$/ do |text|
  current_email.should have_body_text(text)
end

# Basically aliases "I should see [text]", but for third person
Then /^they should see "([^\"]*)"$/ do |text|
  Then "I should see \"#{text}\""
end