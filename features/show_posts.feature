Feature: Show Posts

  Scenario: Home Page
    Given the following approved posts exist
    | tag_list    |
    | ruby, rails |
    | rails, blog |
    | test        |
    When I go to the home page
    Then I should see 3 posts
    And I should see 3 sections
    And I should see "ruby, rails, blog, test" as html meta tags

  Scenario: Textile
    Given a section exists with name: "About"
    And a post exists with title: "Textile", body: "Simple *textile*", section: the section, tag_list: "test, cucumber"
    When I go to Textile's post page
    Then I should see "textile" within "strong"
    And I should see "Textile" tags as html meta tags

  Scenario: RSS
    Given 5 approved posts exist
    When I visit "/posts.rss"
    Then I should see 5 rss items
