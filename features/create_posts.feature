Feature: Creating posts

  Scenario: Creating a post
    Given I am logged in
    And a section exists with name: "Labs"
    And the logged user has a post with title: "Title to see"
    And a post exist with title: "Title not to see"

    When I visit the panel
    Then I should see "Title to see"
    And I should not see "Title not to see"

    When I fill the post form
    And I press "Create Post"
    Then I should see "My post" within ".post .title"

    When I follow "general"
    Then I should be on posts with tag general
