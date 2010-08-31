Feature: List Posts

  Scenario: List of posts 
    Given I am logged in
    When I visit the panel
    Then I should see "Title" 
    And I should see "New post"
