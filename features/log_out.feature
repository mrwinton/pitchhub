Feature: log out
  As a user, I want to log out so that I can keep my account safe

  Scenario: user logs out
    Given I am signed in
    And I click on my name in the header
    And I follow "Log out"
    Then I should be on the new user session page