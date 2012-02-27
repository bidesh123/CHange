Feature: Manage texts
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: Register new text
    Given I am a new, authenticated user
    Then I go to the new text path
    Then I should see "Sign out"
    And I fill the text form with body "<html><body>This is the main text</body></html>" and title "test content" and save it
    Then It is also update Asset table

  Scenario: Edit new text
    Given I am a new, authenticated user
    Then I go to the edit text path
    Then I should see "Sign out"
    And I edit the content of id "1" fill the text form with body "<html><body>This is edit the main text</body></html>" and title "edit test content" and save it

  Scenario: Delete a Text
    Given I am a new, authenticated user
    Then I go to the list of the text page
    Then I delete the text from the list