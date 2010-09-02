Feature: Integrations

  Scenario: Google Analytics 
    Given the Google Analytics code is "UA-1234"
    When I go to the home page
    Then I should see "UA-1234"

  Scenario: Get Clicky
    Given the Get Clicky code is "gc12345"
    When I go to the home page
    Then I should see "gc12345"
