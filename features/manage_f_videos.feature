Feature: Manage videos
  Now first you go to the new videos page
  then I have to chose one movie file and also the corresponding store for that
  movie file would be store here with its actual file path file name and extension

  Scenario: Register new video
    Given I am a new, authenticated user
    When I go to the new video page
    Then I should see "Sign out"
    And I pass the file "movie.swf" and select one store "movies"
