Feature: Show Posts

  Scenario: Home Page
    Given 5 posts exist
    When I go to the home page
    Then I should see 5 posts
    And I should see 5 sections

  Scenario: Check html
    Given a section exists with name: "About"
    And a post exists with title: "h1. Textile", body: "Simple *textile*", section: the section
    When I go to h1. Textile's post page
    Then I should see "textile" within "strong"
    And I should see "Textile" within "h1"
