Feature: Manage users

  Scenario: Creation
    Given I am a logged admin
    And I am on the admin page
    When I follow "New user"
    And I fill the new user form
    And I press "Create User"
    Then an user should exist

  Scenario: Approver
    Given I am a logged admin
    And an user exists
    And I am on the admin page
    When I click to edit the first item
    And I check "Approver?"
    And I press "Update User"
    Then the user should be an approver
