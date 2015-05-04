Feature: user authentication
  As a user, I want to log in so that I can interact with the system.

  Scenario: user logs in
    Given a user with username "foo" and password "secret"
    When I sign in manually as "foo" with password "secret"
    Then I should be on the stream page

  Scenario: user attempts to log in with bogus credentials
    Given a user with username "foo" and password "secret"
    When I sign in manually as "foo" with password "wrong"
    Then I should be on the stream page