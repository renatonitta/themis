Feature: Manage users

  Scenario: Creation
    Given I am a logged admin
    When I go to new user page
    And I fill the new user form
    And I press "Create User"
    Then a user should exist with name: "Ricardo"

  Scenario: Approver
    Given I am a logged admin
    And an user exists
    When I go to the user edition path
    And I check "Approver?"
    And I click "Update User"
    Then the user should be an approver

