Feature: Creating users

  Scenario: Creating a user
    When I go to new user page
    And I fill the new user form
    And I press "Create User"
    Then a user should exist with name: "Ricardo"
