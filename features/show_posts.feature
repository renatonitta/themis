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

  Scenario: Check html
    Given a section exists with name: "About"
    And a post exists with title: "Textile", body: "Simple *textile*", section: the section, tag_list: "test, cucumber"
    When I go to Textile's post page
    Then I should see "textile" within "strong"
    And I should see "Textile" tags as html meta tags

  Scenario: Reading blog's rss feed
    Given 5 approved posts exist
    When I visit "/posts.rss"
    Then I should see 5 rss items

  Scenario: Reading section's rss feed
    Given a section exists with name: "blog"
    And 3 posts exist with section: the section
    When I visit "/sections/blog/posts.rss"
    Then I should see 3 rss items
