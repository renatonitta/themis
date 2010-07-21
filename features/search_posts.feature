Feature: Search posts

  Scenario: Default
    Given a post exists with title: "Ruby on Rails"
    When I go to the home page
    Then I should see the search form
