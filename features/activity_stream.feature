Feature: activity stream
  As a user, I want view to pitches and apply filters so that I can easily look at ideas which interest me

  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
    And I sign in as "foo@foo.foo"

  Scenario: Viewing
    Given I add a new pitch
    When I write the title "A"
    And I submit the pitch

    Given I add a new pitch
    When I write the title "B"
    And I submit the pitch

    Given I add a new pitch
    When I write the title "C"
    And I submit the pitch

    When I go to the activity stream page
    Then "C" should be pitch 1
    Then "B" should be pitch 2
    Then "A" should be pitch 3