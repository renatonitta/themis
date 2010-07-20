Feature: Show comments

  Scenario: Home Page
    Given 2 posts exist
    When I go to the home page
    Then I should see "Add comment"

    When I follow "Add comment"
    And I wait for disqus
    Then I should see "blog comments powered by Disqus"
