Feature: Manage set_users
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: Register new set_user
    Given I am an authenticated admin user
    Then I go to the admin set user path
    Then I follow "Edit"
    Then I go to the edit set user for first user
    Then Admin has changed the Firstname as "Red"
    Then Admin has changed the email as "red@lostbets.com"
    Then press "Save"
    Then Admin redirect to the admin set user show path
    Then I should see notice flash message "Set user was successfully updated."

  Scenario: Destroy One user
    Given I am an authenticated admin user
    Then I go to the admin set user path
    Then I follow "Destroy"
    Then Admin destroy the 3rd user
