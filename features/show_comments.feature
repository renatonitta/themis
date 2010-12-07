Feature: Show comments

  Scenario: Home Page
    Given 2 published posts exist
    When I go to the home page
    Then I should see "Add comment"

    When I follow "Add comment"
    Then I should see "Disqus"
