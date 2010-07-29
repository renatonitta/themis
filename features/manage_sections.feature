Feature: Manage sections

  Background: Admin area
    Given I am a logged admin
    And a section exists with name: "Ruby"
    And I am on the admin sections page

  Scenario: Creation
    When I follow "New section"
    And I fill in "Name" with "Section"
    And I press "Save"
    Then a section should exist with name: "Section"
    And I should be on the admin sections page

  Scenario: Update
    When I click to edit the first item
    And I fill in "Name" with "Section Updated"
    And I press "Save"
    Then a section should exist with name: "Section Updated"
    And I should be on the admin sections page

  Scenario: Destroy
    When I click to destroy the first item 
    Then I should not see "Ruby" 
