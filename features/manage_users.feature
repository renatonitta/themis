Feature: Manage users

  Background: Admin area
    Given I am a logged admin
    And an user exists
    And I am on the admin page

  Scenario: Creation
    When I follow "New user"
    And I fill the new user form
    And I press "Create User"
    Then a user should exist with name: "Ricardo"
    And I should be on the admin page

  Scenario: Approver
    When I click to edit the first item
    And I check "Approver?"
    And I press "Update User"
    Then the user should be an approver
    And I should be on the admin page

