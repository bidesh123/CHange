Feature: Manage manage_searches
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new manage_search
    Given I am on the store wise list path
    And I fill in "search" with "video new"
    And I press "Search"
    And I redirect to the search path
   
    
  