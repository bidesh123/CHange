Feature: Manage images
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: Upload Image
    Given I am a new, authenticated user
    Then I go to the new images path
    Then I should see "Sign out"
    Then I attach the file "pic.jpg" to "image_photo"
    Then It will upload it and also save it
    Then Asset table also updated

  Scenario: Edit The image
    Given I am a new, authenticated user
    And I visit to the edit image path of "pic.gif"
    Then I upload a new image "pic2.jpg"
    Then Asset table is also update

  Scenario: Delete image
#    Given the following images:
#      | id | photo    | source_file_name | source_content_type | source_file_size | source_update_at    |
#      | 1  | pic.jpg  | pic.jpg          | .jpg                | 47379            | 2011-06-02 12:39:31 |
#      | 2  | pic2.jpg | pic2.jpg         | .jpg                | 47379            | 2011-06-02 12:39:31 |
#    When I delete the 3rd image
#    Then I should see the following images:
#      | id | photo   | source_file_name | source_content_type | source_file_size | source_update_at    |
#      | 1  | pic.jpg | pic.jpg          | .jpg                | 47379            | 2011-06-02 12:39:31 |
