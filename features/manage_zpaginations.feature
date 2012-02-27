Feature: Manage paginations

  Scenario: No results
    Given I have 0 videos
    When I view all videos
    Then I should see "No results" on the page

  Scenario: Page links for current page
    Given I have <count> videos
    When I view all videos from page <page>

  Scenario: Next Page links
    Given I have <count> videos
    When I view all videos from page <page>
    Then I should see a link "Previous"

  Scenario: Next Page links on last page
    Given I have <count> videos
    When I view all videos from page <page>
    Then I should see a disabled pagination link "Next"
