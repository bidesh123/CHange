Feature: Manage set_roles
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: Admin edit role of an user
    Given I am an authenticated admin user
    Then I go to the set role path
    Then I follow "Edit"
    Then I go to the edit role for first user
    Then I set the role of the user to "consumer"
    Then I press "Save"

  