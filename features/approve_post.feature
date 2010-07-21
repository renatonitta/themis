Feature: Approve post

  Scenario: Defaul
    Given a post exists
    When I approve the post
    Then the post should not be approved
