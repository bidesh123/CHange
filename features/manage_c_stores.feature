Feature: Manage stores
  Some of our users whose user type is producer
  can  produce as many store as possible.Stores should be disable and enabled by admin.
  Store content different kind of content like images and videos or text contents.
  If it is images it should be in proper format like .jpeg,.gif,.png. If it is videos it should be in proper format
  Like .flv,.wmv and content can be text also.

  Scenario: New Store creation
    Given I am a new, authenticated user
    Then I go to the list store page
    Then I should see "Sign out"
    Then I follow "New Store"
    Then I am redirected to "the new store path"
    Then I fill up the store form with title "new store" and description "A testing store" and an user
    And I follow "Add Image"
    And I follow "Add Video"
    Then I add one image and one video to the store and one snapshot image for video
    Then Again I add one image
    Then Again I add another video
    Then I save the store
    Then I am redirected to the store list wise path

  Scenario: Store edit
    Given I am a new, authenticated user
    Then I go to the list store page
    Then I should see "Sign out"
    Then I follow "Edit"
    Then I am redirected to "the edit store path"
    Then I edit the store of id "1" with title "edit store" and description "the store is updated" and the user

  Scenario: Store Delete
    Given I am a new, authenticated user
    Then I go to the list store page
    Then I should see "Sign out"
    Then I follow "Destroy"
    Then the first store from the list will be destoryed
