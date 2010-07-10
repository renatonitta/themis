Feature: Show Posts

  Scenario: Home Page
    Given 5 posts exist
    When I go to the home page
    Then I should see 5 posts
