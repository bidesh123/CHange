Feature: Manage sortings
  The store list section I can view the all videos with the coresponding store
  Now I want to sort the list of videos of that store.
  
  Scenario: Sorting Category wise
    When I go to the store wise list path
    Then I follow "Category"
    Then It will the video according to the "category"

  Scenario: Sorting Price wise
    When I go to the store wise list path
    Then I follow "Price"
    Then It will the video according to the "price"

  Scenario: Sorting Video Length wise
    When I go to the store wise list path
    Then I follow "Length"
    Then It will the video according to the "length"

   Scenario: Sorting Video Date wise
    When I go to the store wise list path
    Then I follow "Date"
    Then It will the video according to the "date"