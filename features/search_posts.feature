Feature: Search posts

  Scenario: Checking search form
    Given a post exists with title: "Ruby on Rails"
    When I go to the home page
    Then I should see an input type "hidden" with name "sitesearch" and value "www.example.com"
    And I should see an input type "text" with name "q" and value ""
    And I should see a form with action "http://google.com/search"
    And I should see an input type "submit" with name "commit" and value "search"
