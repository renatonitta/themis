Feature: Creating users

  Scenario: Creating a user
    When I go to new user page
    And I fill the new user form
    Then I should see ".posts"
