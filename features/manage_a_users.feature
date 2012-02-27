Feature: Manage users
  User should have register himself on a signup page
  User should have one email or username one password and each user should have a type
  After registration User should authenticate himself on signin page giving his username and password
  User type will be assign by an admin user
  Only one of the user would be admin or super admin
  This  admin can assign many users as a Producer
  and Also admin have the capabilities of making any user as an producer or consumer
  Now there should be two types of consumer one is anonymous consumer and other is registered consumer.
  Register consumer is our register user.

  Scenario: User signs up with invalid data
    When I go to the sign up page
    And I fill in "Email" with "invalid email"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with ""
    Then I should be on the sign up page with a type invalid type
    And Set the role of user as "consumer"
    And I press "Sign up"
    Then I should see error messages

  Scenario: User signs up with valid data
    When I go to the sign up page with a type producer
    And I fill in "Email" with "producer@lostbets.com"
    And I fill in "Password" with "arminus"
    And I fill in "Password confirmation" with "arminus"
    And Set the role of user as "producer"
    And I press "Sign up"
    Then I should see notice flash message "You have signed up successfully. However, we could not sign you in because your account is unconfirmed"

  Scenario: User signs in successfully
    Given I sign in as "producer@lostbets.com/arminus"
    Then I should see notice flash message "Welcome! You have signed up successfully."
    Then I should be on the home page
    Then I should be logged in

  Scenario: User is not signed up
    Given I sign in as "email@person.com/wrong_password"
    Then I should see error messages
    And I should be logged out

  Scenario: User enters wrong password
    Given I sign in as "email@person.com/wrongpassword"
    Then I should be on the sign in page
    And I should see "Invalid email or password"
    And I should be logged out

  Scenario: User is signed in
    Given I am signed up as "producer@lostbets.com/arminus"
    When I go to the sign in page
    And I sign in as "producer@lostbets.com/arminus"
    Then I should see notice flash message "Welcome! You have signed up successfully."
    Then I should be on the home page
    Given I am logged out
    Then I should be logged out

  Scenario: User indicates they have forgotten their password
    When I go to the sign in page
    And I follow "Forgot your password?"
    And I fill the form for forgot password using my email "producer@lostbets.com"
    Then "producer@lostbets.com" should receive 1 email
    Then I should receive an email with a link to a confirmation page
    When I follow "Change my password" in the email
    Then I should be on the password edit page
