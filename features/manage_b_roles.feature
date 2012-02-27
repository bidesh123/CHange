Feature: Manage roles
  There are three different kind of roles i.e. admin, producer, consumer. When user try to sign up as producer,
  the role will be asigne as producer. When user try to sign up as consumer, the role will be asign as consumer.
  Admin can manage these user roles from admin panel.

  Scenario: Register with role producer
    When I go to the sign up page 
    And I fill in "Email" with "producer@lostbets.com"
    And I fill in "Password" with "arminus"
    And I fill in "Password confirmation" with "arminus"
    And Set the role of user as "producer"
    And I press "Sign up"
    Then I should see notice flash message "You have signed up successfully. However, we could not sign you in because your account is unconfirmed"

  Scenario: Register with role consumer
    When I go to the sign up page
    And I fill in "Email" with "consumer@lostbets.com"
    And I fill in "Password" with "arminus"
    And I fill in "Password confirmation" with "arminus"
    And Set the role of user as "consumer"
    And I press "Sign up"
    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed"   
