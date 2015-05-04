Feature: change email
  As a user, I want to change my email so that I can use my active email

  Scenario: Change my email
    Given I am signed in
    When I go to the users edit page
    And I fill in the following:
      | user_email         | foo@foo.foo           |
    And I press "Change email"
    Then I should see "Email changed"
    And I follow the "confirm_email" link from the last sent email
    Then I should see "activated"
    And my "email" should be "foo@foo.foo"
