Feature: Creating posts

  Scenario: Creating a post
    Given I am logged in
    Given 1 sections exist
    When I visit new post
    And I fill in "Title" with "My post"
    And I fill in "Body" with "My test post"
    And I press "Create Post"
    Then I should see "Title: My post"
