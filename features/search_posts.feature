Feature: Search posts

  Scenario: Checking search form
    Given a post exists with title: "Ruby on Rails"
    When I go to the home page
    Then I should see the search form
