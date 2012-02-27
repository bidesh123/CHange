Feature: Manage edit_accounts
  User should authenticate himself first after authenticate by using proper email and password .User should redirect to home page.
  In home Page User click My info link for edit his account
  Now in edit account section user should fill up email password and confirm password.
  If user only filled up password not confirm password then it should throw a validation error.
  And User must filled up current_password fill otherwise he can not be update his account .
  After filling this user should click the Update button
  It will update user account and redirect to home page with flash notice
  "You updated your account successfully."

  Scenario: Update My account info
    Given I am a new, authenticated user
    When I go to the my account page
    Then I fill up the my account page form
    Then I am updated my account successfully
    Then I should see notice flash message "You updated your account successfully."
    
  
  