Feature: reporting a user
  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
    And a user with email "foo@foo.foo" posts a pitch with title "baz"


  @wip
  Scenario: Report a user through a pitch
    Given I sign in as "foo@foo.foo"
    And I am on the pitch's page with title "baz"
    And I report the pitch
    Then I should see "success"

  Scenario: Report a user through an annotation
    Given I sign in as "foo@foo.foo"
    And user "bar@bar.bar" adds an annotation to the pitch with title "baz"
    And I am on the pitch's page with title "baz"
    And I report an annotation
    Then I should see "success"