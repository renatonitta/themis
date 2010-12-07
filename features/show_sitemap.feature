Feature: Sitemap

  Scenario:
    Given a section exist
    And 2 published posts exist with section: the section
    And I am on the sitemap path with format xml
    Then I should see the xml file with sitemap tags
