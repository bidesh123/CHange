Feature: Manage set_other_videos
  This section is for uploading all videos as in lostbets game section there are three type of videos can be uploaded one is highdefination
  others are medium and low.only user can download this videos if he is member on this site.

  Scenario: Register new other videos
    Given I am a new, authenticated admin user
    Then I go to the other videos page
    Then I follow "New Other video"
    Then I go to the new other videos page
    And I attach a file "demo.flv" in "demo_video"
    And I attach a file "main_mp4.mp4" in "main_video_mp4"
    And I attach a file "main_mpeg.mpeg" in "main_video_mpeg"
    And I attach a file "main_wmv.wmv" in "main_video_wmv"
    And I fill in "other_video_title" with "This is the title of the video"
    And I fill in "other_video_description" with "This is the description of the test video for other videos section"
    Then I follow "Add Video Image"
    And I attach a video image file "art3.jpg"
    And I attach a video image file "art4.jpg"
    And I attach a video image file "art5.jpg"
    And I attach a video image file "art6.jpg"
    And I save the details of other videos

  Scenario: Edit the videos also delete it
    Given I am a new, authenticated admin user
    Then I go to the edit other videoes path
    Then I delete the demo video
    Then I also delete the first image
    Then I go to the edit other videoes path
    And I attach a file "movie.swf" in "demo_video" for update
    Then I follow "Add Video Image"
    And I attach a video image file "art3.jpg" for updation
    And I attach a video image file "art4.jpg" for updation
    And I attach a video image file "art5.jpg" for updation
    And I attach a video image file "art6.jpg" for updation
    And I fill in "other_video_title" with "This is the title of the video now it is updated"
    And I fill in "other_video_description" with "This is the description of the test video for other videos section now it is updated"
    And I update the details of the videos section


