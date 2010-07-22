Feature: Approve post

  Scenario: Defaul
    Given I am a logged approver
    And a post exists
    When I approve the post
    Then the post should be approved

  Scenario: Not approver user
    Given I am logged in
    And a post exists
    When I go to the post edition path
    Then I should not see "Approve"
