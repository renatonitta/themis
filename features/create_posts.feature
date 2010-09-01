Feature: Creating posts

  Scenario: Creating a post
    Given I am logged in
    And a section exists with name: "Labs"
    And I have a post with title "New title"
    When I visit the panel
    Then I should see "New title"

    When I fill the post form
    And I press "Create Post"
    Then I should see "My post" within ".post .title"

    When I follow "general"
    Then I should be on posts with tag general
