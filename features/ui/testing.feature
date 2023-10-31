Feature: Testing things
  As a test engineer
  I want to be able to test things here
  In order to write the real code better

  Scenario: Test UI runner
    Given I go to wikipedia
    When I search for term "albert einstein"
    Then I should get multiple results with the term "albert einstein"